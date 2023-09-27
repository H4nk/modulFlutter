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
          title: Text('Contoh Stack'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/background.jpg',
                width: 300.0,
              ),
              Text(
                'Teks di Atas Gambar',
                style: TextStyle(
                    fontSize: 24.0,
                    color: const Color.fromARGB(255, 241, 3, 3)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
