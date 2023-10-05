import 'dart:convert';

import 'package:flutter/foundation.dart';

void main() {
  // Data JSON sebagai string
  String jsonString = '{"nama": "John Doe", "usia": 30}';

  // Menggunakan json.decode() untuk mengurai JSON menjadi objek Dart
  Map<String, dynamic> data = json.decode(jsonString);

  // Membuat objek Person dari data JSON
  Person person = Person.fromJson(data);

  // Menampilkan informasi dari objek Person
  if (kDebugMode) {
    print('Nama: ${person.nama}');
  }
  if (kDebugMode) {
    print('Usia: ${person.usia}');
  }
}

class Person {
  final String nama;
  final int usia;

  // Konstruktor
  Person(this.nama, this.usia);

  // Factory method untuk mengonversi JSON menjadi objek Person
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      json['nama'],
      json['usia'],
    );
  }
}
