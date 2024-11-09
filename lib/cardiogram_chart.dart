import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CardiogramChart extends StatelessWidget {
  final List<FlSpot> cardiogramData;
  final double sliderPosition;
  final double visibleRange;
  final Color color;

  const CardiogramChart({
    Key? key,
    required this.cardiogramData,
    required this.sliderPosition,
    required this.visibleRange,
    this.color = Colors.redAccent,
  }) : super(key: key);

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          duration: const Duration(milliseconds: 0),
          curve: Curves.linear,
          LineChartData(
            lineTouchData: _lineTouchData(),
            minX: sliderPosition,
            maxX: sliderPosition + visibleRange,
            minY: -1,
            maxY: 1,
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
    case -1:
      return Text('-1', style: style);
    case 0:
      return Text('0', style: style);
    case 1:
      return Text('1', style: style);
    default:
      return Container();
  }
}
