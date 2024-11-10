import 'package:ai25front/data/annotation_range.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

class CardiogramChart extends StatelessWidget {
  final List<FlSpot> cardiogramData;
  final double sliderPosition;
  final double visibleRange;
  final Color color;
  final List<AnnotationRange> annotationRanges;

  const CardiogramChart({
    Key? key,
    required this.cardiogramData,
    required this.sliderPosition,
    required this.visibleRange,
    required this.color,
    required this.annotationRanges,
  }) : super(key: key);

  Color getColorForAnnotation(String annotation, {double opacity = 0.2}) {
    switch (annotation) {
      case 'ds1-ds2':
        return Colors.red.withOpacity(opacity);
      case 'is1-is2':
        return Colors.green.withOpacity(opacity);
      default:
        // Без цвета для других аннотаций
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Вычисляем динамические minY и maxY
    final double minY =
        cardiogramData.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final double maxY =
        cardiogramData.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    // Интервал для вертикальных линий
    const int interval = 500000;

    // Количество вертикальных линий
    final int numberOfLines = (visibleRange / interval).ceil();

    // Генерация вертикальных линий
    List<VerticalLine> verticalLines = [];
    for (int i = 1; i <= numberOfLines; i++) {
      double xPosition = sliderPosition + (i * interval);

      if (xPosition > sliderPosition + visibleRange) break;

      Duration labelDuration =
          Duration(milliseconds: (xPosition * (1 / 400)).toInt());
      String formattedTime = [
        labelDuration.inHours.toString().padLeft(2, '0'),
        (labelDuration.inMinutes % 60).toString().padLeft(2, '0'),
        (labelDuration.inSeconds % 60).toString().padLeft(2, '0'),
        (labelDuration.inMilliseconds % 1000).toString().padLeft(3, '0')
      ].join(':');

      verticalLines.add(
        VerticalLine(
          x: xPosition,
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 0.5,
          dashArray: [5, 5],
          label: VerticalLineLabel(
            show: true,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 5),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            direction: LabelDirection.horizontal,
            labelResolver: (line) => formattedTime,
          ),
        ),
      );
    }

    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            duration: const Duration(milliseconds: 0),
            curve: Curves.linear,
            LineChartData(
              rangeAnnotations: RangeAnnotations(
                verticalRangeAnnotations: annotationRanges.map((range) {
                  return VerticalRangeAnnotation(
                    x1: range.x1,
                    x2: range.x2,
                    color:
                        getColorForAnnotation(range.annotation, opacity: 0.15),
                  );
                }).toList(),
              ),
              extraLinesData: ExtraLinesData(
                verticalLines: verticalLines,
              ),
              lineTouchData: _lineTouchData(),
              minX: sliderPosition,
              maxX: sliderPosition + visibleRange,
              minY: minY,
              maxY: maxY,
              titlesData: _buildTitlesData(minY, maxY),
              gridData: _buildGridData(),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: cardiogramData,
                  isCurved: true,
                  color: color,
                  barWidth: 1,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineTouchData _lineTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (_) => Colors.white,
        tooltipBorder: BorderSide(color: Colors.blue, width: 1),
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((spot) => LineTooltipItem(
                    spot.y.toStringAsFixed(5),
                    const TextStyle(color: Colors.black),
                  ))
              .toList();
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData(double minY, double maxY) {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: (maxY - minY) / 4, // Динамический интервал
          getTitlesWidget: (value, meta) =>
              leftTitleWidgets(value, meta, minY, maxY),
          reservedSize: 42,
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.grey.withOpacity(0.2),
        strokeWidth: 1,
      ),
      getDrawingVerticalLine: (value) => FlLine(
        color: Colors.grey.withOpacity(0.2),
        strokeWidth: 1,
      ),
    );
  }
}

// Функция для отображения подписей слева
Widget leftTitleWidgets(
    double value, TitleMeta meta, double minY, double maxY) {
  final style = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87);

  if (value == minY || value == maxY) {
    return Text(value.toStringAsFixed(1), style: style);
  } else if (value == (minY + maxY) / 2) {
    return Text(value.toStringAsFixed(1), style: style);
  } else {
    return Container(); // Пустой контейнер для уменьшения загромождения
  }
}
