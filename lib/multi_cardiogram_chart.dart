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
  
  final double _visibleRange = 5000;
  double _maxSliderPosition = 5000;

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

  void _onSliderChange(double value) {
    setState(() {
      _sliderPosition = value;
      _isAutoScroll = (_sliderPosition >= (_maxSliderPosition - _visibleRange));
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
        // Три графика, каждый с уникальным цветом и своим набором данных
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
        // Общий слайдер и кнопки управления
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Slider(
                value: _sliderPosition.clamp(
                    _xOffset, _maxSliderPosition - _visibleRange),
                min: _xOffset,
                max: _maxSliderPosition - _visibleRange > _xOffset
                    ? _maxSliderPosition - _visibleRange
                    : _xOffset,
                onChanged: (_maxSliderPosition - _visibleRange > _xOffset)
                    ? _onSliderChange
                    : null,
              ),
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