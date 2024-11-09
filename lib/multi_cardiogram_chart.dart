import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'cardiogram_chart.dart';
import 'package:ai25front/cardio_client.dart';
import 'package:ai25front/src/generated/cardio.pb.dart';

class MultiCardiogramChart extends StatefulWidget {
  @override
  _MultiCardiogramChartState createState() => _MultiCardiogramChartState();
}

class _MultiCardiogramChartState extends State<MultiCardiogramChart> {
  final List<FlSpot> _dataChart1 = [];
  final List<FlSpot> _dataChart2 = [];
  final List<FlSpot> _dataChart3 = [];
  late CardioClient _client;
  StreamSubscription<CardioData>? _dataSubscription;

  double _sliderPosition = 0;

  // Make _visibleRange mutable and add initial value
  double _visibleRange = 5000;
  double _maxSliderPosition = 5000;
  final double maxRange = 10000;
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
    _dataChart1.add(FlSpot(0, 0));
    _dataChart2.add(FlSpot(0, 0));
    _dataChart3.add(FlSpot(0, 0));
    _xValue = _dataChart1.length.toDouble();
  }

  void _connectToServer() {
    _client = CardioClient();
    _subscribeToData();
  }

  void _subscribeToData() {
    _dataSubscription = _client.streamCardioData("flutter_client").listen(
      (data) {
        _updateChartData(data.vector);
      },
    );
    setState(() {
      _isStreaming = true;
    });
  }

  void _updateChartData(List<double> vector) {
    setState(() {
      final newPoints =
          vector.map((value) => FlSpot(_xValue++, value)).toList();

      _dataChart1.addAll(newPoints);
      _dataChart2.addAll(newPoints);
      _dataChart3.addAll(newPoints);

      const deleteRange = 20000;
      if (_dataChart1.length > deleteRange) {
        int pointsToRemove = _dataChart1.length - deleteRange;
        _dataChart1.removeRange(0, pointsToRemove);
        _dataChart2.removeRange(0, pointsToRemove);
        _dataChart3.removeRange(0, pointsToRemove);
        _xOffset += pointsToRemove.toDouble();
      }

      _maxSliderPosition =
          _xOffset + (_dataChart1.isNotEmpty ? _dataChart1.last.x : 0);

      if (_isAutoScroll) {
        _sliderPosition = _maxSliderPosition - _visibleRange;
        if (_sliderPosition < _xOffset) {
          _sliderPosition = _xOffset;
        }
      }
    });
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    _client.close();
    super.dispose();
  }

  void _onPositionSliderChange(double value) {
    setState(() {
      _stopStreaming();
      _sliderPosition = value;
      _isAutoScroll = (_sliderPosition >= (_maxSliderPosition - _visibleRange));
    });
  }

  void _onZoomSliderChange(double value) {
    setState(() {
      _visibleRange = value;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Three charts, each with a unique color and its own dataset
        Expanded(
          child: CardiogramChart(
            color: Colors.redAccent,
            sliderPosition: _sliderPosition,
            visibleRange: _visibleRange,
            cardiogramData: _dataChart1,
          ),
        ),
        Expanded(
          child: CardiogramChart(
            color: Colors.blueAccent,
            sliderPosition: _sliderPosition,
            visibleRange: _visibleRange,
            cardiogramData: _dataChart2,
          ),
        ),
        Expanded(
          child: CardiogramChart(
            color: Colors.greenAccent,
            sliderPosition: _sliderPosition,
            visibleRange: _visibleRange,
            cardiogramData: _dataChart3,
          ),
        ),
        // Common slider and control buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Position Slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Position',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: _sliderPosition.clamp(
                        _xOffset, _maxSliderPosition - _visibleRange),
                    min: _xOffset,
                    max: _maxSliderPosition - _visibleRange > _xOffset
                        ? _maxSliderPosition - _visibleRange
                        : _xOffset,
                    onChanged: (_maxSliderPosition - _visibleRange > _xOffset)
                        ? _onPositionSliderChange
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Zoom Slider with Icons and Label
              Row(
                children: [
                  Icon(Icons.zoom_out),
                  Expanded(
                    child: Slider(
                      value: maxRange -
                          _visibleRange, // Inverted value for slider position
                      min: maxRange - 10000, // Max zoom (smallest range)
                      max: maxRange - 1000, // Min zoom (largest range)
                      divisions: 9, // For steps of 1000
                      onChanged: (value) {
                        _onZoomSliderChange(
                            maxRange - value); // Adjust _visibleRange
                      },
                    ),
                  ),
                  Icon(Icons.zoom_in),
                  const SizedBox(width: 8),
                  Text(
                    "X${(_visibleRange / 5000).toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isStreaming ? _stopStreaming : null,
                    child: const Text('Остановить'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: !_isStreaming ? _resumeStreaming : null,
                    child: const Text('Продолжить'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
