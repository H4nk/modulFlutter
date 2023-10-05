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
      title: 'Data Dari Sumber Eksternal',
      home: DataFromExternalSource(),
    );
  }
}

class DataFromExternalSource extends StatefulWidget {
  @override
  _DataFromExternalSourceState createState() => _DataFromExternalSourceState();
}

class _DataFromExternalSourceState extends State<DataFromExternalSource> {
  // Variabel untuk menyimpan data yang diambil dari sumber eksternal
  List<dynamic> data = [];

  // Fungsi untuk mengambil data dari API JSONPlaceholder
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      // Parsing data JSON
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Panggil fungsi fetchData saat widget diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Dari Sumber Eksternal'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(data[index]['title']),
            subtitle: Text(data[index]['body']),
          );
        },
      ),
    );
  }
}
