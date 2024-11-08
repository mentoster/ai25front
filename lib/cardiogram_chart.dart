import 'dart:async';

import 'package:ai25front/cardio_client.dart';
import 'package:ai25front/src/generated/cardio.pb.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CardiogramChart extends StatefulWidget {
  const CardiogramChart({super.key});

  @override
  _CardiogramChartState createState() => _CardiogramChartState();
}

class _CardiogramChartState extends State<CardiogramChart> {
  List<FlSpot> cardiogramData = [];
  CardioClient? _client;
  StreamSubscription<CardioData>? _dataSubscription;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _connectToServer();
  }

  // Initialize with dummy data
  void _initializeData() {
    cardiogramData = List.generate(10, (index) => FlSpot(index.toDouble(), 0));
  }

  // Establish a connection to the gRPC server and start receiving data
  void _connectToServer() {
    _client = CardioClient('localhost', 50051); // Use server IP in production
    _dataSubscription =
        _client!.streamCardioData("flutter_client").listen((data) {
      _updateChartData(data.vector);
    });
  }

  // Update the chart with new data received from the server
  void _updateChartData(List<double> vector) {
    setState(() {
      // Append new data points with continuous x-axis values
      final newPoints = List<FlSpot>.generate(
          vector.length,
          (index) => FlSpot(
              (cardiogramData.length + index).toDouble(), vector[index]));

      cardiogramData.addAll(newPoints);

      // Keep only the latest 100 data points for smooth scrolling effect
      if (cardiogramData.length > 100) {
        cardiogramData.removeRange(0, cardiogramData.length - 100);
      }

      // Re-index x values for a horizontal scroll effect
      cardiogramData = cardiogramData
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value.y))
          .toList();
    });
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    _client?.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 99, // Fixed range to show only the last 100 points
              minY: -15,
              maxY: 15,
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) =>
                    FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
                getDrawingVerticalLine: (value) =>
                    FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: cardiogramData,
                  isCurved: true,
                  color: Colors.redAccent,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              _dataSubscription?.pause();
              await _client?.shutdown();
            },
            child: const Text('Stop Streaming'),
          ),
        ),
      ],
    );
  }
}
