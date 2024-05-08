import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWithAppointments extends StatefulWidget {
  @override
  _CalendarWithAppointmentsState createState() => _CalendarWithAppointmentsState();
}

class _CalendarWithAppointmentsState extends State<CalendarWithAppointments> {
  Map<DateTime, List<dynamic>> _appointments = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTime> _highlightedDays = [];  // Lista para almacenar los días resaltados

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    fetchAppointments();
    fetchHighlightedDays();  // Método para cargar los días resaltados
  }

  void fetchAppointments() async {
    final snapshot = await FirebaseFirestore.instance.collection('appointments').get();
    Map<DateTime, List<dynamic>> tempAppointments = {};
    for (var doc in snapshot.docs) {
      DateTime date = (doc['date'] as Timestamp).toDate();
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);
      tempAppointments[normalizedDate] = tempAppointments[normalizedDate] ?? [];
      tempAppointments[normalizedDate]!.add(doc.data());
    }
    setState(() {
      _appointments = tempAppointments;
    });
  }

  void fetchHighlightedDays() async {
    final snapshot = await FirebaseFirestore.instance.collection('highlightedDays').get();
    List<DateTime> tempHighlightedDays = [];
    for (var doc in snapshot.docs) {
      DateTime date = (doc['date'] as Timestamp).toDate();
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);
      tempHighlightedDays.add(normalizedDate);
    }
    setState(() {
      _highlightedDays = tempHighlightedDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) => _appointments[DateTime(day.year, day.month, day.day)] ?? [],
            calendarFormat: CalendarFormat.month,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                for (DateTime highlightedDay in _highlightedDays) {
                  if (isSameDay(highlightedDay, day)) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFffdcdc),  // El color para resaltar
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                      ),
                    );
                  }
                }
                return null;  // Utiliza el builder predeterminado si el día no está en la lista de resaltados
              },
            ),
          ),
        ),
      ),
    );
  }
}
