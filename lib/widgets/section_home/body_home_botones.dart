import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 22, left: 22, top: 0), // Padding para el contenedor
      child: Container(
        child: Column(
          children: [
            _buildRow('🩺', ' Constantes vitales'), // Primera fila
            Divider(), // Línea divisoria
            _buildRow('❤️', ' Corazón'), // Segunda fila
            Divider(), // Línea divisoria
            _buildRow('📋', ' Historial clínico'), // Tercera fila
            Divider(), // Línea divisoria
            _buildRow('📏', ' Medidas corporales'), // Cuarta fila
            Divider(), // Línea divisoria
            _buildRow('💉', ' Vacunas'), // Quinta fila
            Divider(), // Línea divisoria
            _buildRow('💊', ' Medicamentos'), // Sexta fila
            Divider(), // Línea divisoria
            _buildRow('💤', ' Sueño'), // Sexta fila
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String icon, String text) {
    return Row(
      children: [
        Text(
          icon,
          style: TextStyle(
            fontSize: 20, // Tamaño del emoji
            fontFamily: 'Noto Color Emoji', // Usamos la fuente Noto Color Emoji para los emojis
          ),
        ), // Icono a la izquierda
        SizedBox(width: 10), // Espacio entre el icono y el texto
        Text(
          text,
          style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color.fromARGB(255, 65, 65, 65),
              ),
        ), // Texto
        Spacer(), // Espacio flexible para empujar el segundo icono a la derecha
        Icon(
          Icons.arrow_forward_ios,
          size: 16, // Tamaño del icono
          color: Colors.grey, // Color del icono
        ), // Icono a la derecha
      ],
    );
  }
}
