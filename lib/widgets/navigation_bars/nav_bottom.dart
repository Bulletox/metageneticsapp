import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

enum BottomNavigationIndex {
  History,
  Citas,
  Home,
  Period,
  Profile,
  Test
}

class BottomNavigation extends StatefulWidget {
  final Function(BottomNavigationIndex) onItemSelected;

  BottomNavigation({required this.onItemSelected});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 2; // Inicializamos _selectedIndex con el índice correspondiente a "Home"

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Color.fromARGB(255, 250, 232, 232),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // Llama a la función de devolución de llamada con el índice seleccionado
            widget.onItemSelected(_convertIndexToEnum(index));
          });
        },
        items: _navBarItems,
      ),
    );
  }

  BottomNavigationIndex _convertIndexToEnum(int index) {
    switch (index) {
      case 0:
        return BottomNavigationIndex.History;
      case 1:
        return BottomNavigationIndex.Citas;
      case 2:
        return BottomNavigationIndex.Home;
      case 3:
        return BottomNavigationIndex.Period;
      case 4:
        return BottomNavigationIndex.Profile;
      // case 5:
      //   return BottomNavigationIndex.Test;
      default:
        return BottomNavigationIndex.Home;
    }
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.monitor_heart),
    title: Text(
      'Historial',
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    selectedColor: Colors.redAccent,
    unselectedColor: Colors.grey,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.emergency_rounded),
    title: Text(
      'Citas',
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    selectedColor: Colors.redAccent,
    unselectedColor: Colors.grey,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: Text(
      'Home',
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    selectedColor: Colors.redAccent,
    unselectedColor: Colors.grey,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.calendar_month),
    title: Text(
      'Ovulación',
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    selectedColor: Colors.redAccent,
    unselectedColor: Colors.grey,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: Text(
      'Perfil',
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    selectedColor: Colors.redAccent,
    unselectedColor: Colors.grey,
  ),
  // SalomonBottomBarItem(
  //   icon: const Icon(Icons.settings),
  //   title: Text(
  //     'Test',
  //     style: GoogleFonts.poppins(
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   selectedColor: Colors.redAccent,
  //   unselectedColor: Colors.grey,
  // ),
];
