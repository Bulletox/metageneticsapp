import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyHistorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30), // Margen arriba
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage('lib/assets/fotos/estadistica_pasos.png'), // Ruta de tu imagen de fondo
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20), // Espacio entre la imagen y el Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '🍎', // Emoji de la manzana
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Noto Color Emoji', // Fuente de emojis
                        ),
                      ),
                      SizedBox(width: 10), // Espacio entre el emoji y el texto
                      Text(
                        'Alimentación',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 220,
                  height: 220,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/fotos/estadistica_alimentacion.png'), // Ruta de la primera imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '❤️', // Emoji del corazón
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Noto Color Emoji', // Fuente de emojis
                        ),
                      ),
                      SizedBox(width: 10), // Espacio entre el emoji y el texto
                      Text(
                        'Pulsaciones',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 220,
                  height: 220,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/fotos/frecuencia-cardiaca.jpg'), // Ruta de la segunda imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
