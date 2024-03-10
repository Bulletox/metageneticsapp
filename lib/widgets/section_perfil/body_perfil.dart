import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'body_perfil_inputs.dart'; // Importa el archivo de los inputs

class BodyPerfil extends StatefulWidget {
  @override
  _BodyPerfilState createState() => _BodyPerfilState();
}

class _BodyPerfilState extends State<BodyPerfil> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenedor de título
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Datos personales',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.0), // Espacio entre el título y el resto del contenido
            // Fila con la foto y el texto
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cuadrado con imagen de fondo
                Container(
                  width: 150.0, // Ancho del contenedor de la imagen
                  height: 150.0, // Alto del contenedor de la imagen
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage('lib/assets/fotos/yaya.jpg'), // Ruta de tu imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20.0), // Espacio entre los cuadrados
                // Cuadrado con texto
                Expanded(
                  child: SizedBox(
                    height: 160.0, // Altura del contenedor del texto
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 173, 173),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Merino Castilla, Josefa',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '23/02/1949 (74)',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '49533299Q',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Femenino',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'A+',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          // Divider(color: const Color.fromARGB(123, 0, 0, 0),
                          // thickness: 1.0,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0), // Espacio entre el contenido existente y el nuevo texto
            // Texto "Número Seguridad Social" y número correspondiente
            Text(
              'Nº Seguridad Social: 123456789123',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 10.0), // Espacio entre el texto y la línea divisoria
            // Línea divisoria
            Divider(
              color: const Color.fromARGB(146, 0, 0, 0),
              thickness: 1.0,
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Información',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Agrega el formulario de contacto desde el archivo de los inputs
            InfoForm(),
          ],
        ),
      ),
    );
  }
}
