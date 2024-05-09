import 'package:flutter/material.dart';

class WaterNotification extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onPressed;

  WaterNotification({
    required this.title,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// Ejemplo de uso:
// WaterNotification(
//   title: '¡Hora de beber agua!',
//   text: 'Recuerda mantenerte hidratado.',
//   onPressed: () {
//     // Acción cuando se presiona el botón
//   },
// );
