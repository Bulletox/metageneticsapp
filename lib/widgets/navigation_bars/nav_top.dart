import 'package:flutter/material.dart';
import 'water_notification.dart'; // Importa el widget WaterNotification

class TopNavigation extends StatefulWidget implements PreferredSizeWidget {
  final bool isSwitched;
  final Function(bool) onSwitchChanged;

  const TopNavigation({
    Key? key,
    required this.isSwitched,
    required this.onSwitchChanged,
  }) : super(key: key);

  @override
  _TopNavigationState createState() => _TopNavigationState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopNavigationState extends State<TopNavigation> {
  bool _isHovered = false;

  void _logout() async {
    print('Cerrando sesión...');
    // código de cierre de sesión
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(padding: EdgeInsets.only(left: 20.0, top: 15.0)),
        title: Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTap: _logout,
                child: Icon(
                  Icons.account_circle,
                  size: 40,
                  color: _isHovered ? Colors.red : const Color.fromARGB(200, 255, 82, 82),
                ),
              ),
            ),
          ),
          WaterNotification(), // Aquí se agrega WaterNotification como un hijo de TopNavigation
        ],
      ),
    );
  }
}
