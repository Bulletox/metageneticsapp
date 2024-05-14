import 'package:flutter/material.dart';

class DashedCircleBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCircleBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);
    final double circumference = 2 * 3.14159265358979323846 * radius;
    double distance = 0.0;

    while (distance < circumference) {
      final double startAngle = (distance / circumference) * 360;
      final double sweepAngle = (dashWidth / circumference) * 360;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * 3.14159265358979323846 / 180,
        sweepAngle * 3.14159265358979323846 / 180,
        false,
        paint,
      );

      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
