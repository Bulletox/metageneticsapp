import 'package:flutter/material.dart';
// Importamos el archivo donde está la implementación del grid
import 'package:google_fonts/google_fonts.dart';
import 'package:metageneticsapp/widgets/section_home/body_home_botones.dart';
import 'package:metageneticsapp/widgets/section_home/body_home_grid.dart';

class BodyHome extends StatefulWidget {
  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Datos de salud',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          //search bar
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: Color.fromARGB(78, 158, 158, 158),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Buscar',
                  style: TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                )
              ],
            ),
          ),

          // Grid 4 boxes
          Padding(
            padding: const EdgeInsets.all(22),
            child: SizedBox(
              height: 470, // 350 Para movile simulator (Iphone 13 PRO MAX) 470 para chrome
              child: HomeGrid(), // Utilizamos el widget de GridView personalizado
            ),
          ),

          // Aquí añadimos el nuevo widget
          Align(
            alignment: Alignment.centerLeft,
            child: HomeButton(),
          ),
        ],
      ),
    );
  }
}
