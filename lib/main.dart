import 'package:flutter/material.dart';
import './page/SignInPage2.dart'; // Asegúrate de que la ruta al archivo es correcta.
import 'package:google_fonts/google_fonts.dart'; 
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización de los widgets.
  await Firebase.initializeApp(); // Inicializa Firebase de forma asíncrona.
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
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SignInPage2(), // Usamos SignInPage2 como pantalla de inicio.
    );
  }
}
