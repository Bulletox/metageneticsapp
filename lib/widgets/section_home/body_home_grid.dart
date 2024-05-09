import 'package:flutter/material.dart';
import 'package:metageneticsapp/page/HomePage.dart';
import '../section_citas/body_citas.dart';

class HomeGrid extends StatelessWidget {
  final List<String> imagePaths = [
    'lib/assets/fotos/historial.png',
    'lib/assets/fotos/citas.png',
    'lib/assets/fotos/actividad.png',
    'lib/assets/fotos/recetas.png',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(4, (index) {
        return GestureDetector(
          onTap: () {
            if (index == 1) { // Si se hace clic en el índice 2
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Border radius de 20
            child: Container(
              width: 80,
              height: 80,
              color: Colors.red, // Cambia el color de fondo aquí si lo deseas
              child: Image.asset(
                imagePaths[index], // Asigna la ruta de la imagen correspondiente
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}
