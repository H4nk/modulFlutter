import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

List<Contact> contacts = [
  Contact(name: 'John Doe', phoneNumber: '123-456-7890'),
  Contact(name: 'Jane Smith', phoneNumber: '987-654-3210'),
  // Tambahkan contoh kontak lainnya sesuai kebutuhan
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kontak'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phoneNumber),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailContactPage(contact: contacts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailContactPage extends StatelessWidget {
  final Contact contact;

  DetailContactPage({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              contact.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Nomor Telepon: ${contact.phoneNumber}',
              style: TextStyle(fontSize: 16),
            ),
            // Tambahkan informasi kontak lainnya jika diperlukan.
          ],
        ),
      ),
    );
  }
}
