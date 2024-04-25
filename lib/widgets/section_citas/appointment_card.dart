import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'callappointment.dart' as call_appointment;

class AppointmentCard extends StatelessWidget {
  final call_appointment.AppointmentData appointment;

  const AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definir colores y estilos para la tarjeta
    const cardColor = Color(0xFFffdcdc);
    const titleColor = Colors.black;
    const subTitleColor = Color(0xFF4c4242);
    const detailColor = Color(0xFFFF5151);

    // Puedes ajustar los estilos según tu diseño
    final titleStyle = GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: titleColor,
    );

    final subTitleStyle = GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: subTitleColor,
    );

    final detailStyle = GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: detailColor,
    );

    // Construir la tarjeta de cita
    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la tarjeta
            Text('Atención especializada', style: titleStyle),
            const SizedBox(height: 8), // Espacio vertical

            // Subtítulo (especialidad)
            Text(appointment.specialty, style: subTitleStyle),
            const SizedBox(height: 8), // Espacio vertical

            // ID del doctor
            Text('Dr. ${appointment.doctorName}', style: subTitleStyle),
            const SizedBox(height: 20), // Espacio vertical

            // Detalles de la cita
            Row(
              children: [
                Icon(Icons.location_on, color: subTitleColor, size: 20),
                const SizedBox(width: 3), // Espacio entre el icono y el texto
                Text('CAP Montclar', style: subTitleStyle),
                const Spacer(), // Para empujar la fecha hacia la derecha
                Text(appointment.date, style: detailStyle), // Fecha y hora
              ],
            ),

            // Íconos de acción (editar, eliminar)
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: const [
            //     Icon(Icons.edit, color: titleColor),
            //     SizedBox(width: 10),
            //     Icon(Icons.delete, color: titleColor),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
