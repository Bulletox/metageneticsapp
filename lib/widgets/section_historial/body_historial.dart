import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metageneticsapp/widgets/charts/chartpasos.dart'; // Asegúrate de que este import apunte correctamente a tu widget del gráfico

class BodyHistorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Asegúrate de que el contenido sea desplazable si es necesario
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30), // Margen arriba
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center, // Elimina o comenta esta línea
                  children: [
                    Text(
                      '📊', // Emoji para el gráfico
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Noto Color Emoji', // Fuente para emojis
                      ),
                    ),
                    SizedBox(width: 10), // Espacio entre el emoji y el texto
                    Text(
                      'Estadísticas Semanales',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Espacio entre el texto y el gráfico
                Center(
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white, // Fondo blanco para el contenedor del gráfico
                    ),
                    child: WeeklyBarChart(), // Tu widget de gráfico personalizado
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Espacio entre el gráfico y la siguiente sección
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
      ),
    );
  }
}
