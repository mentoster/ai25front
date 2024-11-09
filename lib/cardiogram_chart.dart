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

  // Slider position and range
  double _sliderPosition = 0;
  final double _visibleRange = 1000;
  bool _isAutoScroll = true; // Auto-scroll mode

  // X-value counter to keep track of the total data points
  double _xValue = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _connectToServer();
  }

  // Initialize with dummy data
  void _initializeData() {
    _cardiogramData.addAll(
      List.generate(1, (index) => FlSpot(index.toDouble(), 0)),
    );
    _xValue = _cardiogramData.length.toDouble();
  }

  // Establish a connection to the gRPC server and start receiving data
  void _connectToServer() {
    _client = CardioClient('localhost', 50051); // Use server IP in production
    _dataSubscription = _client.streamCardioData("flutter_client").listen(
      (data) {
        _updateChartData(data.vector);
      },
    );
  }

  // Update the chart with new data received from the server
  void _updateChartData(List<double> vector) {
    setState(() {
      // Generate new points with correct x-values
      final newPoints = vector.map((value) {
        final point = FlSpot(_xValue, value);
        _xValue += 1;
        return point;
      }).toList();

      _cardiogramData.addAll(newPoints);

      // Limit the data to the latest 1000 points
      // if (_cardiogramData.length > 1000) {
      //   _cardiogramData.removeRange(0, _cardiogramData.length - 1000);
      //   // Adjust slider position if auto-scroll is enabled
      // }

      // Adjust slider position if auto-scroll is enabled
      if (_isAutoScroll) {
        _sliderPosition = _xValue - _visibleRange;
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
        (_xValue - _visibleRange).clamp(0, double.infinity);

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardiogramChartWidget(
                  cardiogramData: _cardiogramData,
                  sliderPosition: _sliderPosition,
                  visibleRange: _visibleRange,
                ),
                SliderWidget(
                  sliderPosition: _sliderPosition,
                  maxSliderPosition: maxSliderPosition,
                  onChanged: _onSliderChange,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _stopStreaming,
                    child: const Text('Остановить'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Slider change handler
  void _onSliderChange(double value) {
    setState(() {
      _sliderPosition = value;
      // Disable auto-scroll if the user changes the slider position
      _isAutoScroll = (_sliderPosition >= _xValue - _visibleRange);
    });
  }

  // Stop streaming data from the server
  Future<void> _stopStreaming() async {
    await _dataSubscription?.cancel();
    await _client.shutdown();
  }
}

class CardiogramChartWidget extends StatelessWidget {
  final List<FlSpot> cardiogramData;
  final double sliderPosition;
  final double visibleRange;

  const CardiogramChartWidget({
    super.key,
    required this.cardiogramData,
    required this.sliderPosition,
    required this.visibleRange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => Colors.white.withOpacity(1),
                  // add black border
                  tooltipBorder: BorderSide(color: Colors.blue, width: 1),
                  // make text black
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      final flSpot = touchedSpot;
                      if (flSpot.x == 0 || flSpot.x == 1) {
                        return null;
                      }
                      return LineTooltipItem(
                        '${flSpot.y.toStringAsFixed(5)}',
                        const TextStyle(color: Colors.black),
                      );
                    }).toList();
                  },
                )),
                minX: sliderPosition,
                maxX: sliderPosition + visibleRange,
                minY: -0.5,
                maxY: 1,
                titlesData: const FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: leftTitleWidgets,
                      reservedSize: 42,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),

                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: cardiogramData,
                    isCurved: true,
                    color: Colors.redAccent,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        inactiveTrackColor: Colors.grey,
        activeTrackColor: Colors.blue,
        thumbColor: Colors.blueAccent,
        overlayColor: Colors.blue.withAlpha(32),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
      ),
      child: Slider(
        value: sliderPosition.clamp(0, maxSliderPosition),
        min: 0,
        max: maxSliderPosition > 0 ? maxSliderPosition : 0,
        onChanged: (maxSliderPosition > 0)
            ? onChanged
            : null, // Disable the slider if there's not enough data15
      ),
    );
  }
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value) {
    case -0.5:
      text = '-0.5';
      break;
    case 0:
      text = '0';
      break;
    case 1:
      text = '1';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
