import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'DashedCircleBorderPainter.dart';

class BodyPeriod extends StatefulWidget {
  @override
  _BodyPeriodState createState() => _BodyPeriodState();
}

class _BodyPeriodState extends State<BodyPeriod> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  // Definir las fechas de inicio y fin del periodo
  DateTime? _periodStart;
  DateTime? _periodEnd;

  // Normas para la predicción
  int _cycleLength = 28;
  int _periodLength = 5; // La regla no puede durar más de 5 días
  int _ovulationWindowStart = 14; // Comienza después de una semana vacía
  int _ovulationWindowEnd = 18;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentMonth();
    });
  }

  void _scrollToCurrentMonth() {
    final double monthHeight = 450; // Estimación de la altura de cada mes
    final double initialOffset = 12 * monthHeight; // Desplazarse a la posición del mes actual
    _scrollController.jumpTo(initialOffset);
  }

  void _selectPeriodDates() async {
    DateTime? startPicked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime.utc(2020, 1, 1),
      lastDate: DateTime.utc(2030, 12, 31),
    );
    if (startPicked != null) {
      DateTime? endPicked = await showDatePicker(
        context: context,
        initialDate: startPicked.add(Duration(days: 1)),
        firstDate: startPicked,
        lastDate: DateTime.utc(2030, 12, 31),
      );
      if (endPicked != null) {
        setState(() {
          _periodStart = startPicked;
          _periodEnd = endPicked;
        });
      }
    }
  }

  bool _isPeriodDay(DateTime day) {
    if (_periodStart == null || _periodEnd == null) return false;
    return day.isAfter(_periodStart!.subtract(Duration(days: 1))) && day.isBefore(_periodEnd!.add(Duration(days: 1)));
  }

  bool _isPredictedPeriodDay(DateTime day) {
    if (_periodStart == null) return false;
    DateTime predictedStart = _periodStart!.add(Duration(days: _cycleLength));
    DateTime predictedEnd = predictedStart.add(Duration(days: _periodLength - 1));
    return day.isAfter(predictedStart.subtract(Duration(days: 1))) && day.isBefore(predictedEnd.add(Duration(days: 1)));
  }

  bool _isOvulationDay(DateTime day) {
    if (_periodStart == null || _periodEnd == null) return false;
    DateTime ovulationStart = _periodStart!.add(Duration(days: _periodLength + 7)); // Semana vacía después del periodo
    DateTime ovulationEnd = ovulationStart.add(Duration(days: _ovulationWindowEnd - _ovulationWindowStart));
    return day.isAfter(ovulationStart.subtract(Duration(days: 1))) && day.isBefore(ovulationEnd.add(Duration(days: 1)));
  }

  bool _isPredictedOvulationDay(DateTime day) {
    if (_periodStart == null) return false;
    DateTime predictedOvulationStart = _periodStart!.add(Duration(days: _cycleLength + _periodLength + 7));
    DateTime predictedOvulationEnd = predictedOvulationStart.add(Duration(days: _ovulationWindowEnd - _ovulationWindowStart));
    return day.isAfter(predictedOvulationStart.subtract(Duration(days: 1))) && day.isBefore(predictedOvulationEnd.add(Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Periodo menstrual',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: List.generate(14, (index) {
                  DateTime focusedMonth = DateTime(
                    _focusedDay.year,
                    _focusedDay.month - 12 + index,
                  );
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: focusedMonth,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay; // update `_focusedDay` here as well
                        });
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: _isPeriodDay(_focusedDay)
                              ? Colors.redAccent.withOpacity(0.5)
                              : _isOvulationDay(_focusedDay)
                                  ? Color.fromRGBO(29, 164, 167, 0.5)
                                  : _isPredictedOvulationDay(_focusedDay)
                                      ? Color.fromRGBO(29, 164, 167, 0.1)
                                      : Colors.grey.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false, // Ocultar los días de otros meses
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        formatButtonShowsNext: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          if (_isPeriodDay(day)) {
                            return Container(
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style: TextStyle().copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          } else if (_isPredictedPeriodDay(day)) {
                            return Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(6.0),
                              child: CustomPaint(
                                painter: DashedCircleBorderPainter(
                                  color: Colors.redAccent,
                                  strokeWidth: 2.0,
                                  dashWidth: 5.0,
                                  dashSpace: 3.0,
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle().copyWith(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                            );
                          } else if (_isOvulationDay(day)) {
                            return Container(
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(29, 164, 167, 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style: TextStyle().copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          } else if (_isPredictedOvulationDay(day)) {
                            return Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(6.0),
                              child: CustomPaint(
                                painter: DashedCircleBorderPainter(
                                  color: Color.fromRGBO(29, 164, 167, 1.0),
                                  strokeWidth: 2.0,
                                  dashWidth: 5.0,
                                  dashSpace: 3.0,
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle().copyWith(color: Color.fromRGBO(29, 164, 167, 1.0)),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Text(
                              '${day.day}',
                              style: TextStyle().copyWith(color: Colors.black),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectPeriodDates,
        tooltip: 'Añadir días de regla',
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
