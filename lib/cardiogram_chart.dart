import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

class CardiogramChart extends StatelessWidget {
  final List<FlSpot> cardiogramData;
  final double sliderPosition;
  final double visibleRange;
  final Color color;

  const CardiogramChart({
    super.key,
    required this.cardiogramData,
    required this.sliderPosition,
    required this.visibleRange,
    this.color = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CardiogramChartWidget(
          cardiogramData: cardiogramData,
          sliderPosition: sliderPosition,
          visibleRange: visibleRange,
          color: color,
        ),
      ),
    );
  }
}

class CardiogramChartWidget extends StatelessWidget {
  final List<FlSpot> cardiogramData;
  final double sliderPosition;
  final double visibleRange;
  final Color color;

  const CardiogramChartWidget({
    Key? key,
    required this.cardiogramData,
    required this.sliderPosition,
    required this.visibleRange,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the start time for the chart
    final DateTime startTime = DateTime.now();

    // Define the interval for vertical lines
    const int interval = 1500;

    // Calculate the number of vertical lines based on the visible range
    final int numberOfLines = (visibleRange / interval).ceil();

    // Generate vertical lines at every 300 x units
    List<VerticalLine> verticalLines = [];
    for (int i = 1; i <= numberOfLines; i++) {
      double xPosition = sliderPosition + (i * interval);

      // Ensure the xPosition does not exceed the maxX
      if (xPosition > sliderPosition + visibleRange) break;
      // Calculate the corresponding time for the label
      Duration labelDuration = Duration(seconds: (xPosition / 400).toInt());

      // Format the time as desired, e.g., "HH:mm:ss"
      String formattedTime = [
        labelDuration.inHours.toString().padLeft(2, '0'),
        (labelDuration.inMinutes % 60).toString().padLeft(2, '0'),
        (labelDuration.inSeconds % 60).toString().padLeft(2, '0')
      ].join(':');

      // Add the VerticalLine with the label
      verticalLines.add(
        VerticalLine(
          x: xPosition,
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 1,
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

    // Optionally, include an initial vertical line at the start position
    verticalLines.add(
      VerticalLine(
        x: sliderPosition,
        color: Colors.grey.withOpacity(0.5),
        strokeWidth: 1,
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
          labelResolver: (line) {
            DateTime initialLabelTime = startTime;
            return "${initialLabelTime.hour.toString().padLeft(2, '0')}:${initialLabelTime.minute.toString().padLeft(2, '0')}:${initialLabelTime.second.toString().padLeft(2, '0')}";
          },
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          duration: const Duration(milliseconds: 0),
          curve: Curves.linear,
          LineChartData(
            extraLinesData: ExtraLinesData(
              verticalLines: verticalLines,
            ),
            lineTouchData: _lineTouchData(),
            minX: sliderPosition,
            maxX: sliderPosition + visibleRange,
            minY: -2,
            maxY: 2,
            titlesData: _buildTitlesData(),
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
                    '${spot.y.toStringAsFixed(5)}',
                    const TextStyle(color: Colors.black),
                  ))
              .toList();
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return const FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
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

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  switch (value.toInt()) {
    case -2:
      return Text('-2', style: style);
    case 0:
      return Text('0', style: style);
    case 2:
      return Text('2', style: style);
    default:
      return Container();
  }
}
