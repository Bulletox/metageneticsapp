import 'package:flutter/material.dart';
import 'package:metageneticsapp/widgets/section_historial/body_historial.dart';
import 'package:metageneticsapp/widgets/section_perfil/body_perfil.dart';
import '../widgets/navigation_bars/nav_bottom.dart';
import '../widgets/navigation_bars/nav_top.dart';
import '../widgets/section_home/body_home.dart';
import '../widgets/section_historial/body_historial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSwitched = true; // Definimos _isSwitched como verdadero por defecto

  BottomNavigationIndex _selectedTabIndex = BottomNavigationIndex.Home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigation(
        isSwitched: _isSwitched, // Pasamos el valor de _isSwitched aquí
        onSwitchChanged: (value) {
          setState(() {
            _isSwitched = value; // Actualizamos el valor de _isSwitched cuando cambia el switch
          });
        },
      ),
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _getBody(_selectedTabIndex),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(
        onItemSelected: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBody(BottomNavigationIndex index) {
    switch (index) {
      case BottomNavigationIndex.History:
        return BodyHistorial();
      case BottomNavigationIndex.Appointments:
        return BodyHome();
      case BottomNavigationIndex.Home:
        return BodyHome();
      case BottomNavigationIndex.Profile:
        return BodyPerfil();
      default:
        return Container(); // Devolvemos un widget vacío por defecto
    }
  }
}
