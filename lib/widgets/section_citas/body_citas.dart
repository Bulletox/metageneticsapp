import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metageneticsapp/widgets/section_citas/callappointment.dart' as call_appointment;
import 'package:metageneticsapp/widgets/section_citas/calendar.dart';
import 'package:metageneticsapp/widgets/section_citas/appointment_card.dart' as appointment_card;
import 'package:metageneticsapp/widgets/section_citas/task/add_task_dialog.dart';

class BodyCitas extends StatelessWidget {
  final VoidCallback onAddTask;

  BodyCitas({Key? key, required this.onAddTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: CalendarWithAppointments(),
          ),
          Expanded(
            child: StreamBuilder<List<call_appointment.AppointmentData>>(
              stream: call_appointment.getAppointmentsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Error al cargar los datos: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return appointment_card.AppointmentCard(
                          appointment: snapshot.data![index]);
                    },
                  );
                } else {
                  return Center(child: Text('No hay citas disponibles'));
                }
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ScheduleAppointmentDialog(
                  onScheduleAppointment: (String doctorName, DateTime date) {
                // Aquí puedes agregar la lógica para manejar la nueva cita médica
                print(
                    "Cita programada con el doctor: $doctorName en la fecha: $date");
              });
            },
          );
        },
        child: Icon(Icons.add),
        // shape: CircleBorder(),
        backgroundColor: Color.fromARGB(255, 165, 201, 202),
      ),
    );
  }
}
