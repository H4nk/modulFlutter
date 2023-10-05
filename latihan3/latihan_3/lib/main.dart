import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Interaksi dan Navigasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemListScreen(),
    );
  }
}

class Item {
  final String title;
  final String description;

  Item({required this.title, required this.description});
}

class ItemListScreen extends StatelessWidget {
  final List<Item> items = [
    Item(
      title: 'Bahasa Pemograman Java',
      description:
          'Java adalah bahasa pemrograman yang paling umum digunakan dalam pengembangan aplikasi Android. Java dikembangkan oleh Sun Microsystems (sekarang milik Oracle) pada tahun 1995 dan merupakan bahasa pemrograman yang sangat fleksibel dan mudah dipelajari. Java dapat digunakan untuk membuat berbagai jenis aplikasi mulai dari untuk desktop, situs web, dan seluler.',
    ),
    Item(
      title: 'Bahasa Pemograman Kotlin',
      description:
          'Kotlin adalah bahasa pemrograman yang juga populer digunakan dalam pengembangan aplikasi Android. Kotlin dikembangkan oleh JetBrains dan diluncurkan pada tahun 2016. Kotlin ditujukan untuk menjadi bahasa pemrograman yang lebih modern dan fleksibel daripada Java',
    ),
    Item(
      title: 'Bahasa C++',
      description:
          'C++ adalah bahasa yang lebih umum dan berorientasi pada objek yang mendukung alokasi memori dinamis untuk membuatnya berjalan lebih cepat; sangat berguna untuk aplikasi intensif CPU seperti gim. Banyak pengembang perangkat lunak memanfaatkan C++ untuk pengembangan lintas platform atau untuk pengembangan natif dalam aplikasi Java atau Kotlin.',
    ),
    Item(
      title: 'Bahasa C#',
      description:
          'C# adalah bahasa pemrograman .NET yang dikembangkan oleh Microsoft dan didukung oleh Visual Studio. C# dianggap sebagai bahasa “inti” karena berfungsi dengan baik dan dapat digunakan untuk berbagai proyek. C# didasarkan pada pemrograman berorientasi objek, sehingga memungkinkan untuk membangun aplikasi secara bertahap dan mendukung pengelolaan yang lebih mudah.',
    ),
    Item(
      title: 'Bahasa Phyton',
      description:
          'Python adalah bahasa pemrograman tingkat tinggi yang mudah digunakan dan dapat membantu mempercepat waktu pengembangan. Selain itu, Phyton juga dilengkapi dengan komunitas sumber terbuka yang besar serta kerangka kerja dan perpustakaan yang kuat.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Bahasa Pemograman'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  final Item item;

  ItemDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              item.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
