import 'package:flutter/material.dart';

// Model data item
class ListItem {
  final String title;
  final String description;

  ListItem({required this.title, required this.description});
}

// Widget untuk tampilan detil item
class DetailScreen extends StatelessWidget {
  final ListItem item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item'),
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

// Widget untuk daftar item
class ListScreen extends StatelessWidget {
  final List<ListItem> itemList = [
    ListItem(
      title: 'Item 1',
      description: 'Deskripsi Item 1',
    ),
    ListItem(
      title: 'Item 2',
      description: 'Deskripsi Item 2',
    ),
    ListItem(
      title: 'Item 3',
      description: 'Deskripsi Item 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Item'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final item = itemList[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListScreen(),
  ));
}
