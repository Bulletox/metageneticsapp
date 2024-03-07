import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool isSmallScreen;
  const Logo({Key? key, required this.isSmallScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String largeLogoPath = "lib/assets/images/logo-white.png";

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Image.asset(
        largeLogoPath,
        width: isSmallScreen ? 300 : 200,
        height: isSmallScreen ? null : 200,
        fit: BoxFit.contain,
      ),
    );
  }
}
