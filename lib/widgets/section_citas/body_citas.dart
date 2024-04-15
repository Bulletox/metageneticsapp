import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyCitas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Consulta tus citas',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        //search bar
        SizedBox(
          width: double.infinity, // Hace que el contenedor ocupe todo el ancho
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: Color(0xFFffdcdc),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Atención especializada',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.edit, color: Colors.black),
                        SizedBox(width: 10),
                        Icon(Icons.delete, color: Colors.black),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 0), // Reducido el espacio vertical
                Text(
                  'Ginecología',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF5151),
                  ),
                ),
                SizedBox(height: 0), // Reducido el espacio vertical
                Text(
                  'Dra. Cristina González',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4c4242),
                  ),
                ),
                SizedBox(height: 20), // Pequeño margen de altura
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFF4c4242),
                      size: 20,
                    ),
                    SizedBox(width: 3), // Espacio entre el icono y el texto
                    Text(
                      'CAP Montclar',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4c4242),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Jueves 20 de Marzo a las 22:00',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFF5151),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
