import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Example',
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Masuk atau Daftar',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _errorMessage ?? '',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(),
              child: Text('Masuk dengan Email/Password'),
            ),
            ElevatedButton(
              onPressed: () => _signUpWithEmailAndPassword(),
              child: Text('Daftar dengan Email/Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signInWithGoogle(),
              child: Text('Masuk dengan Google'),
            ),
            ElevatedButton(
              onPressed: () => _signOut(),
              child: Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        setState(() {
          _errorMessage = null;
        });
        print('Masuk dengan email: ${user.email}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        setState(() {
          _errorMessage = null;
        });
        print('Pengguna berhasil terdaftar dengan email: ${user.email}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        setState(() {
          _errorMessage = null;
        });
        print('Masuk dengan Google: ${user.displayName}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      print('Pengguna berhasil keluar');
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Terjadi kesalahan saat keluar: $e');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
