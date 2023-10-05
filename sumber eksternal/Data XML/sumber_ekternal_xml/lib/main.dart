import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data XML',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://data.bmkg.go.id/DataMKG/TEWS/gempadirasakan.xml'));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final elements = document.findAllElements(
          'gempa'); // Ganti 'gempa' dengan nama elemen XML yang sesuai.

      final dataList = elements.map((element) {
        final tanggal = element.findElements('Tanggal').single.text;
        final jam = element.findElements('Jam').single.text;
        final lintang = element.findElements('Lintang').single.text;
        final bujur = element.findElements('Bujur').single.text;
        final magnitude = element.findElements('Magnitude').single.text;

        return 'Tanggal: $tanggal, Jam: $jam, Lintang: $lintang, Bujur: $bujur, Magnitude: $magnitude';
      }).toList();

      setState(() {
        data = dataList;
      });
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Gempa'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]),
          );
        },
      ),
    );
  }
}
