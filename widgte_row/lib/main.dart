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
          title: Text('Contoh Row'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.star, size: 50.0, color: Colors.yellow),
              Text(
                'Rating: 4.5',
                style: TextStyle(fontSize: 20.0),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Beri Rating'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
