import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Duración del periodo y del ciclo
  const int periodLength = 5; // 5 días de periodo
  const int cycleLength = 28; // Ciclo de 28 días

  // Fecha inicial (último periodo conocido)
  DateTime currentPeriodStart = DateTime(2024, 4, 1);
  DateTime currentPeriodEnd = currentPeriodStart.add(Duration(days: periodLength - 1));

  // Generar periodos anteriores
  List<Map<String, DateTime>> periodosEjemplo = [];
  for (int i = 0; i < 12; i++) { // 12 periodos para el año anterior
    periodosEjemplo.add({
      'start': currentPeriodStart,
      'end': currentPeriodEnd,
    });
    // Calcular el inicio del periodo anterior
    currentPeriodStart = currentPeriodStart.subtract(Duration(days: cycleLength));
    currentPeriodEnd = currentPeriodStart.add(Duration(days: periodLength - 1));
  }

  // Añadir los periodos a Firestore
  for (var periodo in periodosEjemplo) {
    await firestore.collection('periods').add({
      'start': Timestamp.fromDate(periodo['start']!),
      'end': Timestamp.fromDate(periodo['end']!),
    });
  }

  print('Datos de ejemplo añadidos correctamente.');
}
