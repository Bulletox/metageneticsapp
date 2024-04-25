import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SingleMonthCalendar extends StatefulWidget {
  @override
  _SingleMonthCalendarState createState() => _SingleMonthCalendarState();
}

class _SingleMonthCalendarState extends State<SingleMonthCalendar> {
  DateTime _focusedDay = DateTime(2024, 4, 1);
  DateTime _selectedDay = DateTime(2024, 4, 24);
  DateTime _firstDay = DateTime(2024, 4, 1);
  DateTime _lastDay = DateTime(2024, 4, 30);

  // Lista de días para resaltar
  final List<DateTime> _highlightedDays = [
    DateTime(2024, 4, 5),
    DateTime(2024, 4, 12)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400), // Ancho máximo del contenedor
          child: Column(
            children: [
              Flexible(
                child: TableCalendar(
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay; // update `_focusedDay` here as well
                      });
                    }
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: ''
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      for (DateTime highlightedDay in _highlightedDays) {
                        if (isSameDay(highlightedDay, day)) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFffdcdc), // El color para resaltar
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                          );
                        }
                      }
                      // Utiliza el builder predeterminado si el día no está en la lista de resaltados.
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
