import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class WaterNotification extends StatefulWidget {
  @override
  _WaterNotificationState createState() => _WaterNotificationState();
}

class _WaterNotificationState extends State<WaterNotification> with SingleTickerProviderStateMixin {
  late Timer _timer;
  bool _isPopupOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  OverlayEntry? _overlayEntry;
  String _notificationText = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1),  // Inicia fuera de la pantalla, arriba
      end: Offset(0, 0),  // Termina en su posición normal
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (!_isPopupOpen) {
        _showReminderPopup(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<String> _getRandomNotification() async {
    final Random random = Random();
    int randomNumber = random.nextInt(10) + 1; // Genera un número aleatorio entre 1 y 10
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Notificaciones').doc('$randomNumber').get();
    return documentSnapshot['text'] ?? '';
  }

  void _showReminderPopup(BuildContext context) async {
    if (!_isPopupOpen) {
      _isPopupOpen = true;
      _controller.forward();

      final notificationText = await _getRandomNotification();
      setState(() {
        _notificationText = notificationText;
      });

      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Dismissible(
            key: Key('water_notification'),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              setState(() {
                _isPopupOpen = false;
                _controller.reverse();
                _overlayEntry?.remove();
                _overlayEntry = null; // Establece el OverlayEntry a null después de eliminarlo
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 20), // Espacio desde la parte superior
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Color(0xFFC2D8FA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: _buildNotificationContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRow('💧', '¡Recuerda hidratarte!'),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isPopupOpen = false;
                  _controller.reverse();
                  _overlayEntry?.remove();
                  _overlayEntry = null; // Establece el OverlayEntry a null después de eliminarlo
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            _notificationText,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              color: Color(0xFF302F2F),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none, // Sin subrayado
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String icon, String text) {
    return Row(
      children: [
        Text(
          icon,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Noto Color Emoji',
            decoration: TextDecoration.none, 
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Color(0xFF302F2F),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none, // Sin subrayado
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
