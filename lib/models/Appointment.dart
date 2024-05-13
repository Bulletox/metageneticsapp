class Appointment {
  String patientName;
  String reason;
  DateTime date;

  Appointment({required this.patientName, required this.reason, required this.date});

  // Convertir de un mapa, útil para instanciar desde datos de base de datos o externos
  factory Appointment.fromMap(Map<String, dynamic> data) {
    return Appointment(
      patientName: data['patientName'],
      reason: data['reason'],
      date: DateTime.parse(data['date']),
    );
  }

  // Convertir a un mapa, útil para enviar a bases de datos o APIs
  Map<String, dynamic> toMap() {
    return {
      'patientName': patientName,
      'reason': reason,
      'date': date.toIso8601String(),
    };
  }

  // Método para obtener una representación string del objeto, útil para depuración
  @override
  String toString() {
    return 'Appointment{patientName: $patientName, reason: $reason, date: $date}';
  }
}
