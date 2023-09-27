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
          title: Text('Tata Letak dengan Container dan Column'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16.0), // Padding di sekitar tata letak
            color: Colors.lightBlue, // Warna latar belakang Container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ini adalah teks dalam Container',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                SizedBox(height: 20.0), // Jarak antara teks dan tombol
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Tombol dalam Container'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
