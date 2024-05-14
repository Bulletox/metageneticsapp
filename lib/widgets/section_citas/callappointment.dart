import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentData {
  final String doctorName;
  final String date;
  final String specialty;
  final String color;
  final String colorLight;

  AppointmentData({
    required this.doctorName,
    required this.date,
    required this.specialty,
    required this.color,
    required this.colorLight,
  });

  factory AppointmentData.fromMap(
      Map<String, dynamic> map,
      String doctorName,
      String specialty,
      String color,
      String colorLight) {
    var formattedDate = DateFormat('dd/MM/yyyy HH:mm')
        .format((map['date'] as Timestamp).toDate());

    return AppointmentData(
      doctorName: doctorName,
      date: formattedDate,
      specialty: specialty,
      color: color,
      colorLight: colorLight,
    );
  }
}

Future<List<AppointmentData>> getAppointments() async {
  QuerySnapshot<Map<String, dynamic>> appointmentSnapshot =
      await FirebaseFirestore.instance.collection('appointments').get();

  List<AppointmentData> appointments = [];

  for (var doc in appointmentSnapshot.docs) {
    var data = doc.data();

    if (data['doctor_id'] == null || data['date'] == null) continue;

    // Obtener la información del doctor
    var doctorDoc = await (data['doctor_id'] as DocumentReference).get();
    var doctorData = doctorDoc.data() as Map<String, dynamic>;
    var doctorName = doctorData['name'] ?? 'Nombre no disponible';
    var specialty = doctorData['speciality'] ?? 'Especialidad no disponible';

    // Obtener la información del color
    var colorDoc = await (doctorData['color'] as DocumentReference).get();
    var colorData = colorDoc.data() as Map<String, dynamic>;
    var color = colorData['hex'] ?? 'Color no disponible';
    var colorLight = colorData['hexLight'] ?? 'Color Light no disponible';

    // Convertir la fecha
    var formattedDate = DateFormat('dd/MM/yyyy HH:mm')
        .format((data['date'] as Timestamp).toDate());

    // Añadir el objeto de la cita a la lista
    appointments.add(AppointmentData(
      doctorName: doctorName,
      date: formattedDate,
      specialty: specialty,
      color: color,
      colorLight: colorLight,
    ));
  }

  return appointments;
}

Stream<List<AppointmentData>> getAppointmentsStream() {
  return FirebaseFirestore.instance.collection('appointments').snapshots().asyncMap((snapshot) async {
    List<AppointmentData> appointments = [];

    for (var doc in snapshot.docs) {
      var data = doc.data();

      if (data['doctor_id'] == null || data['date'] == null) continue;

      // Obtener la información del doctor
      var doctorDoc = await (data['doctor_id'] as DocumentReference).get();
      var doctorData = doctorDoc.data() as Map<String, dynamic>;
      var doctorName = doctorData['name'] ?? 'Nombre no disponible';
      var specialty = doctorData['speciality'] ?? 'Especialidad no disponible';

      // Obtener la información del color
      var colorDoc = await (doctorData['color'] as DocumentReference).get();
      var colorData = colorDoc.data() as Map<String, dynamic>;
      var color = colorData['hex'] ?? 'Color no disponible';
      var colorLight = colorData['hexLight'] ?? 'Color Light no disponible';

      // Convertir la fecha
      var formattedDate = DateFormat('dd/MM/yyyy HH:mm')
          .format((data['date'] as Timestamp).toDate());

      // Añadir el objeto de la cita a la lista
      appointments.add(AppointmentData(
        doctorName: doctorName,
        date: formattedDate,
        specialty: specialty,
        color: color,
        colorLight: colorLight,
      ));
    }

    return appointments;
  });
}
