import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int hitung = 0;

  void tombolDitekan() {
    setState(() {
      hitung++; // Menambah hitung setiap kali tombol ditekan
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contoh Tombol dan Event Handling'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tombol telah ditekan $hitung kali',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 20.0), // Jarak antara teks dan tombol
              ElevatedButton(
                onPressed: tombolDitekan,
                child: Text('Tekan Tombol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
