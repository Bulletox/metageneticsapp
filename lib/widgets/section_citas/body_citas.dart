import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Importa AppointmentData y getAppointments con el prefijo call_appointment.
import 'package:metageneticsapp/widgets/section_citas/callappointment.dart'
    as call_appointment;
import 'package:metageneticsapp/widgets/section_citas/calendar.dart';
// Importa AppointmentCard con el prefijo appointment_card.
import 'package:metageneticsapp/widgets/section_citas/appointment_card.dart'
    as appointment_card;

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
          child: CalendarWithAppointments(),
        ),
        Expanded(
          child: FutureBuilder<List<call_appointment.AppointmentData>>(
            future: call_appointment.getAppointments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Imprimir el error en la consola
                debugPrint("Error al cargar citas: ${snapshot.error}");
                // Mostrar el error en la UI
                return Center(
                    child:
                        Text('Error al cargar los datos: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<call_appointment.AppointmentData> appointments =
                    snapshot.data ?? [];
                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return appointment_card.AppointmentCard(
                        appointment: appointments[index]);
                  },
                );
              } else {
                return Center(child: Text('No hay citas disponibles'));
              }
            },
          ),
        )
      ],
    );
  }
}
