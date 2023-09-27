import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HalamanPertama(),
    );
  }
}

class HalamanPertama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Pertama'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ini adalah Halaman Pertama'),
            SizedBox(height: 20.0), // Jarak antara teks dan tombol
            ElevatedButton(
              onPressed: () {
                // Navigasi ke Halaman Kedua saat tombol ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HalamanKedua()),
                );
              },
              child: Text('Pindah ke Halaman Kedua'),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanKedua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Kedua'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ini adalah Halaman Kedua'),
            SizedBox(height: 20.0), // Jarak antara teks dan tombol
            ElevatedButton(
              onPressed: () {
                // Kembali ke Halaman Pertama saat tombol ditekan
                Navigator.pop(context);
              },
              child: Text('Kembali ke Halaman Pertama'),
            ),
          ],
        ),
      ),
    );
  }
}
