import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metageneticsapp/widgets/section_citas/task/date_input_widget.dart';

class Doctor {
  final String id;
  final String name;
  final String specialty;

  Doctor({required this.id, required this.name, required this.specialty});

  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Doctor(
      id: doc.id, // Obtiene el ID del documento directamente del snapshot.
      name: data['name'] as String,
      specialty: data['speciality'] as String,
    );
  }
}

class ScheduleAppointmentDialog extends StatefulWidget {
  final Function(String, DateTime) onScheduleAppointment;

  const ScheduleAppointmentDialog(
      {Key? key, required this.onScheduleAppointment})
      : super(key: key);

  @override
  _ScheduleAppointmentDialogState createState() =>
      _ScheduleAppointmentDialogState();
}

class _ScheduleAppointmentDialogState extends State<ScheduleAppointmentDialog> {
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  List<Doctor> doctors = [];
  String? selectedSpecialty;
  Doctor? selectedDoctor;
  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  void loadDoctors() async {
    FirebaseFirestore.instance.collection('Doctores').get().then((snapshot) {
      setState(() {
        doctors =
            snapshot.docs.map((doc) => Doctor.fromFirestore(doc)).toList();
      });
    }).catchError((e) {
      print('Error al cargar los doctores: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 231, 246, 242),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedSpecialty,
                decoration: const InputDecoration(
                    labelText: "Selecciona una especialidad"),
                items: doctors
                    .map((doctor) => doctor.specialty)
                    .toSet()
                    .toList()
                    .map((String specialty) {
                  return DropdownMenuItem<String>(
                    value: specialty,
                    child: Text(specialty),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSpecialty = value;
                    filteredDoctors = doctors
                        .where((doctor) => doctor.specialty == value)
                        .toList();
                    selectedDoctor = null;
                  });
                },
                validator: (value) => value == null
                    ? 'Por favor seleccione una especialidad'
                    : null,
              ),
              if (filteredDoctors.isNotEmpty)
                DropdownButtonFormField<Doctor>(
                  value: selectedDoctor,
                  decoration:
                      const InputDecoration(labelText: "Selecciona un doctor"),
                  items: filteredDoctors.map((Doctor doctor) {
                    return DropdownMenuItem<Doctor>(
                      value: doctor,
                      child: Text(doctor.name),
                    );
                  }).toList(),
                  onChanged: (Doctor? doctor) {
                    setState(() {
                      selectedDoctor = doctor;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Por favor seleccione un doctor' : null,
                ),
              DateInputWidget(
                selectedDate: _selectedDate,
                onSelectDate: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Primero valida el formulario
              if (selectedDoctor != null && _selectedDate != null) {
                addAppointment(); // Llama a la función que añade la cita a Firestore
              } else {
                print("Debe seleccionar un doctor y una fecha.");
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 165, 201, 202)),
          child: const Text('Programar Cita'),
        ),
      ],
    );
  }

  Future<void> addAppointment() async {
    if (_formKey.currentState!.validate() &&
        selectedDoctor != null &&
        _selectedDate != null) {
      DocumentReference doctorRef = FirebaseFirestore.instance
          .collection('Doctores')
          .doc(selectedDoctor!.id);
      Map<String, dynamic> appointmentData = {
        'date': Timestamp.fromDate(_selectedDate!), // Firestore usa Timestamp
        'doctor_id': doctorRef,
        // 'user_id': userId,  // Asegúrate de agregar el userId si es necesario.
      };

      try {
        await FirebaseFirestore.instance
            .collection('appointments')
            .add(appointmentData);
        print("Cita añadida con éxito!");
        Navigator.of(context)
            .pop(); // Cierra el diálogo después de añadir la cita
      } catch (e) {
        print("Error al añadir cita: $e");
      }
    } else {
      print("Formulario no válido o datos incompletos");
    }
  }
}
