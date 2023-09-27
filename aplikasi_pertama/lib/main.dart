import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contoh Text dan Image'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Widget Image untuk menampilkan gambar dari proyek Anda
              Image.asset(
                'assets/gambar_saya.png', // Ganti dengan path gambar Anda
                width: 150.0,
              ),

              SizedBox(height: 20.0), // Jarak antara gambar dan teks

              // Widget Text untuk menampilkan teks di bawah gambar
              Text(
                'Ini adalah contoh teks',
                style: TextStyle(fontSize: 20.0, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
