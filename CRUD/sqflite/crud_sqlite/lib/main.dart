import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final databasePath = await getDatabasesPath();

  final database = await openDatabase(
    join(databasePath, 'db_mhs.db'),
    onCreate: (db, version) {
      db.execute('''
        CREATE TABLE students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          nim TEXT,
          jurusan TEXT
        )
      ''');
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Mahasiswa UNES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(database: database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Database database;

  const MyHomePage({Key? key, required this.database}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();

  int? _selectedStudentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mahasiswa UNES'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchStudents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final students = snapshot.data!;

          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nama'),
                    ),
                    TextField(
                      controller: _nimController,
                      decoration: InputDecoration(labelText: 'NIM'),
                    ),
                    TextField(
                      controller: _jurusanController,
                      decoration: InputDecoration(labelText: 'Jurusan'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_selectedStudentId == null) {
                          // Tambahkan data baru
                          await insertStudent({
                            'name': _nameController.text,
                            'nim': _nimController.text,
                            'jurusan': _jurusanController.text,
                          });
                        } else {
                          // Perbarui data yang ada
                          await updateStudent(_selectedStudentId!, {
                            'name': _nameController.text,
                            'nim': _nimController.text,
                            'jurusan': _jurusanController.text,
                          });
                          _selectedStudentId =
                              null; // Setel kembali menjadi null setelah perubahan
                        }
                        _nameController.clear();
                        _nimController.clear();
                        _jurusanController.clear();
                        setState(() {});
                      },
                      child: Text(_selectedStudentId == null
                          ? 'Tambah Mahasiswa'
                          : 'Update Mahasiswa'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return ListTile(
                      title: Text(student['name']),
                      subtitle: Text(
                          'NIM: ${student['nim']}, Jurusan: ${student['jurusan']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Saat tombol edit ditekan, isi formulir dengan data mahasiswa yang ada
                              setState(() {
                                _selectedStudentId = student['id'];
                                _nameController.text = student['name'];
                                _nimController.text = student['nim'];
                                _jurusanController.text = student['jurusan'];
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await deleteStudent(student['id']);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchStudents() async {
    final List<Map<String, dynamic>> students =
        await widget.database.query('students');
    return students;
  }

  Future<void> insertStudent(Map<String, dynamic> student) async {
    await widget.database.insert('students', student);
  }

  Future<void> updateStudent(int id, Map<String, dynamic> student) async {
    await widget.database
        .update('students', student, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteStudent(int id) async {
    await widget.database.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}
