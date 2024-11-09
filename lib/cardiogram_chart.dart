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
  final List<FlSpot> _cardiogramData = [];
  late CardioClient _client;
  StreamSubscription<CardioData>? _dataSubscription;

  double _sliderPosition = 0;
  final double _visibleRange = 5000;
  bool _isAutoScroll = true;
  bool _isStreaming = true;

  double _xValue = 0;
  double _xOffset = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _connectToServer();
  }

  void _initializeData() {
    _cardiogramData.add(FlSpot(0, 0));
    _xValue = _cardiogramData.length.toDouble();
  }

  void _connectToServer() {
    _client = CardioClient('localhost', 50051);
    _subscribeToData();
  }

  void _subscribeToData() {
    _dataSubscription = _client.streamCardioData("flutter_client").listen(
          (data) => _updateChartData(data.vector),
        );
    setState(() {
      _isStreaming = true;
    });
  }

  void _updateChartData(List<double> vector) {
    setState(() {
      final newPoints =
          vector.map((value) => FlSpot(_xValue++, value)).toList();
      _cardiogramData.addAll(newPoints);

      const deleteRange = 20000;
      if (_cardiogramData.length > deleteRange) {
        int pointsToRemove = _cardiogramData.length - deleteRange;
        _cardiogramData.removeRange(0, pointsToRemove);
        _xOffset += pointsToRemove.toDouble();
        _sliderPosition =
            (_sliderPosition - pointsToRemove).clamp(0, double.infinity);
      }

      if (_isAutoScroll) {
        _sliderPosition = _xValue - _xOffset - _visibleRange;
      }
    });
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    _client.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxSliderPosition =
        (_xValue - _xOffset - _visibleRange).clamp(0, double.infinity);

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child:
                CardiogramChartWidget(
                  cardiogramData: _cardiogramData,
                  sliderPosition: _sliderPosition,
                  visibleRange: _visibleRange,
                  xOffset: _xOffset,
                      ),
                    )),
                SliderWidget(
                  sliderPosition: _sliderPosition,
                  maxSliderPosition: maxSliderPosition,
                  onChanged: _onSliderChange,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _stopStreaming,
                        child: const Text('Остановить'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _isStreaming ? null : _resumeStreaming,
                        child: const Text('Продолжить'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSliderChange(double value) {
    // Остановим поток при перемещении слайдера
    _stopStreaming();
    setState(() {
      _sliderPosition = value;
      _isAutoScroll = (_sliderPosition >= _xValue - _xOffset - _visibleRange);
    });
  }

  void _stopStreaming() {
    _dataSubscription?.cancel();
    setState(() {
      _isStreaming = false;
    });
  }

  void _resumeStreaming() {
    _subscribeToData();
  }
}

class CardiogramChartWidget extends StatelessWidget {
  final List<FlSpot> cardiogramData;
  final double sliderPosition;
  final double visibleRange;
  final double xOffset;

  const CardiogramChartWidget({
    super.key,
    required this.cardiogramData,
    required this.sliderPosition,
    required this.visibleRange,
    required this.xOffset,
  });

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
            // rangeAnnotations: RangeAnnotations(
            //   verticalRangeAnnotations: [
            //     VerticalRangeAnnotation(
            //       x1: -0.5,
            //       x2: 100000,
            //       color: Colors.green.withOpacity(0.3),
            //     ),
            //   ],
            // ),
            lineTouchData: _lineTouchData(),
            minX: sliderPosition + xOffset,
            maxX: sliderPosition + xOffset + visibleRange,
            minY: -1,
            maxY: 1,
            titlesData: _buildTitlesData(),
            gridData: _buildGridData(),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: cardiogramData,
                isCurved: true,
                color: Colors.redAccent,
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

class SliderWidget extends StatelessWidget {
  final double sliderPosition;
  final double maxSliderPosition;
  final ValueChanged<double> onChanged;

  const SliderWidget({
    super.key,
    required this.sliderPosition,
    required this.maxSliderPosition,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: sliderPosition.clamp(0, maxSliderPosition),
      min: 0,
      max: maxSliderPosition,
      onChanged: (maxSliderPosition > 0) ? onChanged : null,
      inactiveColor: Colors.grey,
      activeColor: Colors.blue,
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
