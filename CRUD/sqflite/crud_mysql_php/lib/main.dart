import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Mahasiswa {
  final int id;
  final String nama;
  final String nim;
  final String jurusan;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.nim,
    required this.jurusan,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: int.parse(json['id'].toString()), // Konversi 'id' menjadi int
      nama: json['nama'] as String,
      nim: json['nim'] as String,
      jurusan: json['jurusan'] as String,
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MahasiswaListScreen(),
    );
  }
}

class MahasiswaListScreen extends StatefulWidget {
  const MahasiswaListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MahasiswaListScreenState createState() => _MahasiswaListScreenState();
}

class _MahasiswaListScreenState extends State<MahasiswaListScreen> {
  List<Mahasiswa> _mahasiswaList = [];
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMahasiswa();
  }

  Future<void> fetchMahasiswa() async {
    final response =
        await http.get(Uri.parse('https://your_php_server/mahasiswa'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      setState(() {
        _mahasiswaList = data.map((item) => Mahasiswa.fromJson(item)).toList();
      });
    }
  }

  Future<void> addMahasiswa(String nama, String nim, String jurusan) async {
    final response = await http.post(
      Uri.parse('https://your_php_server/mahasiswa'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nim': nim,
        'nama': nama,
        'jurusan': jurusan,
      }),
    );

    if (response.statusCode == 200) {
      // Berhasil menambahkan data, tambahkan logika sesuai kebutuhan
      fetchMahasiswa(); // Refresh daftar mahasiswa
      _nimController.clear();

      _namaController.clear();
      _jurusanController.clear();
    }
  }

  Future<void> editMahasiswa(
      int id, String nama, String nim, String jurusan) async {
    final response = await http.put(
      Uri.parse('https://your_php_server/mahasiswa/mahasiswa/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': nama,
        'nim': nim,
        'jurusan': jurusan,
      }),
    );

    if (response.statusCode == 200) {
      // Berhasil mengedit data, tambahkan logika sesuai kebutuhan
      fetchMahasiswa(); // Refresh daftar mahasiswa
      _namaController.clear();
      _nimController.clear();
      _jurusanController.clear();
    }
  }

  Future<void> deleteMahasiswa(int id) async {
    final response = await http
        .delete(Uri.parse('https://your_php_server/mahasiswa/mahasiswa/$id'));

    if (response.statusCode == 200) {
      // Berhasil menghapus data, tambahkan logika sesuai kebutuhan
      fetchMahasiswa(); // Refresh daftar mahasiswa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mahasiswa'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(labelText: 'NIM'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _jurusanController,
              decoration: const InputDecoration(labelText: 'Jurusan'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addMahasiswa(
                _nimController.text,
                _namaController.text,
                _jurusanController.text,
              );
            },
            child: const Text('Tambah Mahasiswa'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _mahasiswaList.length,
              itemBuilder: (context, index) {
                final mahasiswa = _mahasiswaList[index];
                return ListTile(
                  title: Text(mahasiswa.nama),
                  subtitle: Text(
                      'NIM: ${mahasiswa.nim}, Jurusan: ${mahasiswa.jurusan}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          editMahasiswa(
                            mahasiswa.id,
                            _namaController.text,
                            _nimController.text,
                            _jurusanController.text,
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteMahasiswa(mahasiswa.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
