import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class BodyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Test Page',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        WaterReminderPopup(),
      ],
    );
  }
}

class WaterReminderPopup extends StatefulWidget {
  @override
  _WaterReminderPopupState createState() => _WaterReminderPopupState();
}

class _WaterReminderPopupState extends State<WaterReminderPopup> {
  late Timer _timer;
  bool _isPopupOpen = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (!_isPopupOpen) {
        _showReminderPopup(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showReminderPopup(BuildContext context) {
    _isPopupOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          content: Container(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRow('💧', '¡Recuerda hidratarte!'),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        _isPopupOpen = false;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'Beber agua es muy importante para el cuerpo.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Color(0xFF302F2F),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFFC2D8FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        );
      },
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
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Color(0xFF302F2F),
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
