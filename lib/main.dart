import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metageneticsapp/firebase_options.dart';
import 'page/sign_in_page.dart';

 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegúrate de llamar a este método al inicio
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Utiliza las opciones de firebase_options.dart
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metagenetics App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Agrega Google Fonts al tema.
      ),
      home: const SignInPage2(),
      // home: const SignUpPage(), // Usamos SignInPage2 como pantalla de inicio.
    );
  }
}
