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
          title: Text('Contoh Widget Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Widget Row untuk menampilkan teks dan ikon dalam satu baris horizontal
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, size: 50.0, color: Colors.yellow),
                  Text(
                    'Rating: 4.5',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),

              SizedBox(height: 20.0), // Jarak antara widget

              // Widget Stack untuk menempatkan teks di atas gambar dalam lapisan
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/background.jpg',
                    width: 300.0,
                  ),
                  Text(
                    'Teks di Atas Gambar',
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                ],
              ),

              SizedBox(height: 20.0), // Jarak antara widget

              // Widget Container untuk mengelilingi tata letak dalam satu wadah
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.lightBlue,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Ini adalah teks dalam Container',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    SizedBox(height: 10.0), // Jarak antara teks dan tombol
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Tombol dalam Container'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
