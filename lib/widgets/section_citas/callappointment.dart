import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentData {
  final String doctorName; // Cambiado de doctorId a doctorName
  final String date;
  final String specialty;

  AppointmentData({
    required this.doctorName, // Cambiado de doctorId a doctorName
    required this.date,
    required this.specialty,
  });

  // Se asume que este método ahora recibirá el nombre del doctor además de la fecha y especialidad.
  factory AppointmentData.fromMap(Map<String, dynamic> map, String doctorName) {
    // Formatea la fecha a un formato legible, como 'dd/MM/yyyy HH:mm'.
    var formattedDate = DateFormat('dd/MM/yyyy HH:mm').format((map['date'] as Timestamp).toDate());
    
    return AppointmentData(
      doctorName: doctorName, // Usar el nombre del doctor proporcionado
      date: formattedDate,
      specialty: map['specialty'] ?? '',
    );
  }
}

Future<List<AppointmentData>> getAppointments() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('appointments').get();

  List<AppointmentData> appointments = [];
  for (var doc in querySnapshot.docs) {
    var appointmentData = doc.data() as Map<String, dynamic>;

    // Asegúrate de que doctor_id no sea null antes de proceder
    if (appointmentData['doctor_id'] == null) {
      continue; // Si es null, omitir este documento y continuar con el siguiente
    }

    DocumentReference doctorRef = appointmentData['doctor_id'] as DocumentReference;

    // Verifica si la referencia del doctor existe y obtiene el documento
    DocumentSnapshot doctorSnapshot = await doctorRef.get();

    String doctorName = 'Nombre no disponible';
    String specialty = 'Especialidad no disponible';
    if (doctorSnapshot.exists && doctorSnapshot.data() != null) {
      Map<String, dynamic> doctorData = doctorSnapshot.data() as Map<String, dynamic>;
      doctorName = doctorData['name'] ?? 'Nombre no disponible';
      specialty = doctorData['specialty'] ?? 'Especialidad no disponible';
    }

    // Convertir el Timestamp a String para la fecha
    var formattedDate = '';
    if (appointmentData['date'] is Timestamp) {
      formattedDate = DateFormat('dd/MM/yyyy HH:mm').format((appointmentData['date'] as Timestamp).toDate());
    }

    // Crea el objeto AppointmentData con la información obtenida
    AppointmentData appointment = AppointmentData(
      doctorName: doctorName,
      date: formattedDate,
      specialty: specialty, // Usar la especialidad obtenida
    );
    appointments.add(appointment);
  }

  return appointments;
}


