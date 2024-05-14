import 'package:flutter/material.dart';

class DateInputWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onSelectDate;

  const DateInputWidget({
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.blue, // Cambia el color del calendario aquí
                  onPrimary: Colors.white, // Cambia el color del texto del calendario aquí
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.black), // Cambia el color del texto del botón de fecha aquí
                ),
                // Ajusta otros estilos según sea necesario
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.blue, // Cambia el color del time picker aquí
                    onPrimary: Colors.white, // Cambia el color del texto del time picker aquí
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(color: Colors.black), // Cambia el color del texto del botón de tiempo aquí
                  ),
                  // Ajusta otros estilos según sea necesario
                ),
                child: child!,
              );
            },
          );

          if (pickedTime != null) {
            final dateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
            onSelectDate(dateTime);
          }
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Fecha y hora de entrega',
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (selectedDate != null)
              Text(
                _formatDateTime(selectedDate!),
                style: const TextStyle(color: Color.fromARGB(255, 44, 51, 51), fontWeight: FontWeight.bold),
              )
            else
              const Text(
                'Seleccione la fecha y la hora',
                style: TextStyle(color: Colors.grey),
              ),
            const Icon(Icons.calendar_today, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}
