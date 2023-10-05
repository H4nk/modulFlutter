import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Gempa BMKG',
      home: GempaListScreen(),
    );
  }
}

class Gempa {
  final String tanggal;
  final String jam;
  final String lintang;
  final String bujur;
  final String magnitudo;
  final String kedalaman;
  final String wilayah;
  final String potensi;

  Gempa({
    required this.tanggal,
    required this.jam,
    required this.lintang,
    required this.bujur,
    required this.magnitudo,
    required this.kedalaman,
    required this.wilayah,
    required this.potensi,
  });

  factory Gempa.fromJson(Map<String, dynamic> json) {
    return Gempa(
      tanggal: json['Tanggal'],
      jam: json['Jam'],
      lintang: json['Lintang'],
      bujur: json['Bujur'],
      magnitudo: json['Magnitude'],
      kedalaman: json['Kedalaman'],
      wilayah: json['Wilayah'],
      potensi: json['Potensi'],
    );
  }
}

class GempaListScreen extends StatefulWidget {
  @override
  _GempaListScreenState createState() => _GempaListScreenState();
}

class _GempaListScreenState extends State<GempaListScreen> {
  late Future<List<Gempa>> gempaList;

  @override
  void initState() {
    super.initState();
    gempaList = fetchData();
  }

  Future<List<Gempa>> fetchData() async {
    final response = await http.get(
        Uri.parse('https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final List<Gempa> gempas = (jsonData['Infogempa']['gempa'] as List)
          .map((data) => Gempa.fromJson(data))
          .toList();
      return gempas;
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Gempa BMKG'),
      ),
      body: FutureBuilder<List<Gempa>>(
        future: gempaList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data gempa yang tersedia.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final gempa = snapshot.data![index];
                return ListTile(
                  title: Text(gempa.wilayah),
                  subtitle: Text('Magnitude: ${gempa.magnitudo}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GempaDetailScreen(gempa: gempa),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class GempaDetailScreen extends StatelessWidget {
  final Gempa gempa;

  GempaDetailScreen({required this.gempa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Gempa'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wilayah: ${gempa.wilayah}'),
            Text('Tanggal: ${gempa.tanggal}'),
            Text('Jam: ${gempa.jam}'),
            Text('Lintang: ${gempa.lintang}'),
            Text('Bujur: ${gempa.bujur}'),
            Text('Magnitude: ${gempa.magnitudo}'),
            Text('Kedalaman: ${gempa.kedalaman}'),
            Text('Potensi: ${gempa.potensi}'),
          ],
        ),
      ),
    );
  }
}
