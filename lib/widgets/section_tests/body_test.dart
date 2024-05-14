import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      ],
    );
  }
}
