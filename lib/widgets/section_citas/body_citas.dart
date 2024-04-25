import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appointment_card.dart'; // Importa el widget AppointmentCard
import 'calendar.dart'; // Importa el widget AppointmentCard

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
        Expanded(  // Asegura que el widget de calendario tenga espacio para expandirse
          child: SingleMonthCalendar(),
        ),
        Expanded(  // Hace scroll todas las tarjetas de citas
          child: ListView(
            children: [
              AppointmentCard(),
              SizedBox(height: 15), // Ajuste de espacio vertical
              AppointmentCard(),
              // Añade más tarjetas según sea necesario
            ],
          ),
        ),
      ],
    );
  }
}
