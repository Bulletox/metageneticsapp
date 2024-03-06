import 'package:flutter/material.dart';
import './page/SignInPage2.dart'; // Asegúrate de que la ruta al archivo es correcta.;
// import 'package:firebase_admin/firebase_admin.dart';
// import 'package:firebase_admin/src/credential.dart';
 // Import your Firebase options

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metagenetics App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Agrega Google Fonts al tema.
      ),
      home: const SignInPage2(), // Usamos SignInPage2 como pantalla de inicio.
    );
  }
}
