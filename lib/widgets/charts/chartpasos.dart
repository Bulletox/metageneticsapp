import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<double> yValues = [
    1500,
    3700,
    3200,
    7000,
    2000,
    1700,
    2400
  ]; 

  @override
  Widget build(BuildContext context) {
    // Calculando el valor máximo y añadiendo un margen.
    final maxY = yValues.reduce(max) *
        1.1; // Encuentra el valor más alto y añade un 10% de margen.

    return AspectRatio(
      aspectRatio: 2,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 16.0, left: 6.0, top: 24, bottom: 12),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY, // Usa el maxY calculado
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  margin: 10,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Lun';
                      case 1:
                        return 'Mar';
                      case 2:
                        return 'Mié';
                      case 3:
                        return 'Jue';
                      case 4:
                        return 'Vie';
                      case 5:
                        return 'Sáb';
                      case 6:
                        return 'Dom';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  margin: 8,
                  reservedSize: 30,
                  interval: 1000,
                  getTitles: (value) {
                    return '${value.toInt()}';
                  },
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 1000,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.black12,
                  strokeWidth: 1.0,
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black12, width: 1),
              ),
              barGroups: List.generate(yValues.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: yValues[index],
                      colors: [Colors.redAccent],
                      width: 50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            5), // Ajusta el radio según tus necesidades
                        topRight: Radius.circular(4),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Scaffold(body: Center(child: WeeklyBarChart()))));
}
