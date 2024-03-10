import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoForm extends StatefulWidget {
  @override
  _InfoFormState createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController calleNumeroController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController correoElectronicoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Asignar valores iniciales a los controladores
    provinciaController.text = 'Barcelona';
    ciudadController.text = 'Sant Baudili de Llobregat';
    calleNumeroController.text = 'C/ Marianao, 3';
    telefonoController.text = '123456789';
    correoElectronicoController.text = 'pepi12@gmail.com';
  }

  @override
  void dispose() {
    // Guardar los valores al cerrar la página
    _saveValues();
    super.dispose();
  }

  void _saveValues() {
    // Aquí puedes guardar los valores en una base de datos o en otro lugar
    // En este ejemplo, simplemente mostraremos los valores en la consola
    print('Provincia: ${provinciaController.text}');
    print('Ciudad: ${ciudadController.text}');
    print('Calle y número: ${calleNumeroController.text}');
    print('Teléfono: ${telefonoController.text}');
    print('Correo electrónico: ${correoElectronicoController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provincia',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: provinciaController,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                fillColor: Color.fromARGB(50, 255, 82, 82),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0), // Padding izquierda: 15.0
                floatingLabelBehavior: FloatingLabelBehavior.always, // Mueve el texto del label arriba
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0), // Espacio entre los campos de texto
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ciudad',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: ciudadController,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(50, 255, 82, 82),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0), // Padding izquierda: 15.0
                floatingLabelBehavior: FloatingLabelBehavior.always, // Mueve el texto del label arriba
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0), // Espacio entre los campos de texto
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calle y número',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: calleNumeroController,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(50, 255, 82, 82),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0), // Padding izquierda: 15.0
                floatingLabelBehavior: FloatingLabelBehavior.always, // Mueve el texto del label arriba
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0), // Espacio entre los campos de texto
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teléfono',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: telefonoController,
              style: GoogleFonts.poppins(),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(50, 255, 82, 82),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0), // Padding izquierda: 15.0
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0), // Espacio entre los campos de texto
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Correo electrónico',
              style: GoogleFonts.poppins(),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: correoElectronicoController,
              style: GoogleFonts.poppins(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(50, 255, 82, 82),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0), // Padding izquierda: 15.0
              ),
            ),
          ],
        ),
      ],
    );
  }
}
