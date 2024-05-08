import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Importa AppointmentData y getAppointments con el prefijo call_appointment.
// import 'package:metageneticsapp/widgets/section_citas/callappointment.dart'
//     as call_appointment;
import 'package:metageneticsapp/widgets/section_citas/calendar.dart';
// Importa AppointmentCard con el prefijo appointment_card.
// import 'package:metageneticsapp/widgets/section_citas/appointment_card.dart'
//     as appointment_card;

class BodyPeriod extends StatelessWidget {
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
            'Periodo menstrual',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(  // Asegura que el widget de calendario tenga espacio para expandirse
          child: CalendarWithAppointments(),
        ),
      ],
    );
  }
}
