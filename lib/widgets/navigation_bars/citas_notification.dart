import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class CitasNotification extends StatefulWidget {
  @override
  _CitasNotificationState createState() => _CitasNotificationState();
}

class _CitasNotificationState extends State<CitasNotification> with SingleTickerProviderStateMixin {
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

    _timer = Timer(Duration(seconds: 3), () {
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

  Future<String> _getNextAppointmentNotification() async {
    QuerySnapshot appointmentsSnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .orderBy('date')
        .limit(1)
        .get();

    if (appointmentsSnapshot.docs.isEmpty) {
      return 'No tienes citas próximas.';
    }

    DocumentSnapshot appointmentDoc = appointmentsSnapshot.docs.first;
    Timestamp dateTimestamp = appointmentDoc['date'];
    DateTime appointmentDate = dateTimestamp.toDate();
    DocumentReference doctorRef = appointmentDoc['doctor_id'];

    DocumentSnapshot doctorDoc = await doctorRef.get();
    String doctorName = doctorDoc['name'];

    String formattedDate = "${appointmentDate.day}-${appointmentDate.month}-${appointmentDate.year}";
    String formattedTime = "${appointmentDate.hour}:${appointmentDate.minute.toString().padLeft(2, '0')}";

    return 'Tienes una cita el próximo $formattedDate a las $formattedTime con el doctor $doctorName';
  }

  void _showReminderPopup(BuildContext context) async {
    if (!_isPopupOpen) {
      _isPopupOpen = true;
      _controller.forward();

      final notificationText = await _getNextAppointmentNotification();
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
            key: Key('citas_notification'),
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
                color: Color.fromARGB(255, 250, 194, 194),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
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
            _buildRow('📋', '¡Tienes una nueva cita!'),
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
