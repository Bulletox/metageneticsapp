import 'package:flutter/material.dart';

import 'page/sign_in_page.dart';
// import 'page/sign_up_page.dart';
// import './page/SignInPage2.dart'; // Asegúrate de que la ruta al archivo es correcta.;
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Agrega Google Fonts al tema.
      ),
      home: const SignInPage2(),
      // home: const SignUpPage(), // Usamos SignInPage2 como pantalla de inicio.
    );
  }
}
