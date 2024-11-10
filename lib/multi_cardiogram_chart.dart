import 'dart:async';
import 'package:ai25front/data/set_file_to_process_response_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'cardiogram_chart.dart';
import 'package:ai25front/cardio_client.dart';
import 'package:ai25front/src/generated/cardio.pb.dart';

class ChannelData {
  final String name;
  final Color color;
  final List<FlSpot> data;

  ChannelData({required this.name, required this.color})
      : data = [];
}

class MultiCardiogramChart extends StatefulWidget {
  const MultiCardiogramChart({super.key});

  @override
  _MultiCardiogramChartState createState() => _MultiCardiogramChartState();
}

class _MultiCardiogramChartState extends State<MultiCardiogramChart> {
  final List<ChannelData> _availableChannels = [];
  final Set<String> _selectedChannelNames = {};
  late CardioClient _client;
  StreamSubscription<CardioData>? _dataSubscription;

  double _sliderPosition = 0;
double _visibleRange = 400000; // Set to 5 times 80000 for a zoom-out effect
  final double maxRange = 800000; // Set max range accordingly
  double _maxSliderPosition = 80000;
  bool _isAutoScroll = true;
  bool _isStreaming = true;

  final double _xValue = 0;
  double _xOffset = 0;
  bool _isMouseCardCreated = false;
  @override
  void initState() {
    super.initState();
    _initializeChannels();
    _connectToServer();
    _isMouseCardCreated = SetFileToProcessResponseData.pharm;
  }

  void _initializeChannels() {
    _availableChannels.addAll([
      ChannelData(
          name: SetFileToProcessResponseData.label1, color: Colors.redAccent),
      ChannelData(
          name: SetFileToProcessResponseData.label2, color: Colors.blueAccent),
      ChannelData(
          name: SetFileToProcessResponseData.label3, color: Colors.greenAccent),
      // Add more channels if needed
    ]);

    // By default, select all channels
    _selectedChannelNames.addAll(_availableChannels.map((c) => c.name));
  }

  void _connectToServer() {
    _client = CardioClient();
    _subscribeToData();
  }

  void _subscribeToData() {
    _dataSubscription = (SetFileToProcessResponseData.isAnnotated
            ? _client.streamAnnotatedData("flutter_client")
            : _client.streamCardioData("flutter_client"))
        .listen(
      (data) {
        _updateChartData(data);
      },
    );
    setState(() {
      _isStreaming = true;
    });
  }

  void _updateChartData(CardioData data) {
    setState(() {
      print("Updating chart data...");

      for (final channel in _availableChannels) {
        List<double> vectorData;
        if (channel.name == SetFileToProcessResponseData.label1) {
          vectorData = data.vector1;
        } else if (channel.name == SetFileToProcessResponseData.label2) {
          vectorData = data.vector2;
        } else if (channel.name == SetFileToProcessResponseData.label3) {
          vectorData = data.vector3;
        } else {
          vectorData = [];
        }
        // Map the incoming data to FlSpot points and add to channel data
        // final newPoints =
        //     vectorData.map((value) => FlSpot(_xValue++, value)).toList();
        // channel.data.addAll(newPoints);
        for (int i = 0; i < vectorData.length; i++) {
          double newX = (data.timestamp[i] * 100000).roundToDouble();

          // Only add the point if the new x is greater than the last x in channel data
          if (channel.data.isEmpty || newX > channel.data.last.x) {
            print(newX); // Print the new x value
            channel.data.add(FlSpot(newX, vectorData[i]));
          }
        }

        // Remove old data if it exceeds the delete range
        const deleteRange = 200000;
        int pointsToRemove = channel.data.length - deleteRange;
        if (pointsToRemove > 0 && pointsToRemove < channel.data.length) {
          channel.data.removeRange(0, pointsToRemove);
        }
      }

      // Calculate _xOffset based on the minimum x value across all channels
      _xOffset = _availableChannels
          .where((channel) => channel.data.isNotEmpty)
          .map((channel) => channel.data.first.x)
          .reduce((a, b) => a < b ? a : b);

      // Calculate _maxSliderPosition based on the last x value across all channels
      _maxSliderPosition = _availableChannels
          .where((channel) => channel.data.isNotEmpty)
          .map((channel) => channel.data.last.x)
          .reduce((a, b) => a > b ? a : b);

      // Update the slider position if auto-scrolling is enabled
      if (_isAutoScroll) {
        _sliderPosition = (_maxSliderPosition - _visibleRange)
            .clamp(_xOffset, _maxSliderPosition);
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
      _sliderPosition =
          value.clamp(_xOffset, _maxSliderPosition - _visibleRange);
      _isAutoScroll = (_sliderPosition >= (_maxSliderPosition - _visibleRange));
    });
  }

  void _onZoomSliderChange(double value) {
    setState(() {
      // Clamp _visibleRange to ensure it fits the new 5x zoomed-out range
      _visibleRange = value.clamp(40000.0, maxRange);
      _sliderPosition =
          _sliderPosition.clamp(_xOffset, _maxSliderPosition - _visibleRange);
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
      // to left align the content
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
                width: 350, // Установите ширину для всей формы
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Информация о пациенте',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Поля в горизонтальном `Row`
                              Row(
                                children: [
                                  // Поле для возраста
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Возраст',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      controller: TextEditingController(
                                        text: SetFileToProcessResponseData.age,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Поле для выбора пола
                                  const SizedBox(width: 16),
                                  // Boolean переключатель
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Есть карта',
                                            style: TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Switch(
                                          value: _isMouseCardCreated,
                                          onChanged: (bool value) {
                                            setState(() {
                                              _isMouseCardCreated = value;
                                            });
                                          },
                                          activeColor: Colors.blueAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ])))),
            SizedBox(
              height: 128,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Выбор канала',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: _availableChannels.map((channel) {
                          return FilterChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: channel.color,
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  channel.name,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            selected:
                                _selectedChannelNames.contains(channel.name),
                            onSelected: (isSelected) {
                              setState(() {
                                if (isSelected) {
                                  _selectedChannelNames.add(channel.name);
                                } else {
                                  _selectedChannelNames.remove(channel.name);
                                }
                              });
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: channel.color.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            checkmarkColor: channel.color,
                            side: BorderSide(
                              color: channel.color.withOpacity(0.7),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _availableChannels
                  .where(
                      (channel) => _selectedChannelNames.contains(channel.name))
                  .map((channel) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          height: 200,
                          child: CardiogramChart(
                            color: channel.color,
                            sliderPosition: _sliderPosition,
                            visibleRange: _visibleRange,
                            cardiogramData: channel.data,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Position Slider
                Text(
                  'Позиция',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.grey,
                    inactiveTrackColor: Colors.grey,
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
                  ),
                  child: Slider(
                    divisions: 150,
                    value: _sliderPosition.clamp(
                        _xOffset, _maxSliderPosition - _visibleRange),
                    min: _xOffset,
                    max: (_maxSliderPosition - _visibleRange)
                        .clamp(_xOffset, double.infinity),
                    onChanged: (_maxSliderPosition - _visibleRange > _xOffset)
                        ? _onPositionSliderChange
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // Zoom Slider with Icons and Label
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.zoom_out, color: Colors.grey),
                    // Adjust the slider min and max based on the allowed range
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 4.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 8.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 14.0),
                          overlayColor: Colors.greenAccent.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: maxRange - _visibleRange,
                          min: maxRange -
                              700000, // Adjust min to allow further zoom-out
                          max: maxRange -
                              40000, // Keep max to allow full zoom-in
                          divisions: 9,
                          onChanged: (value) {
                            _onZoomSliderChange(maxRange - value);
                          },
                        ),
                      ),
                    ),

                    Icon(Icons.zoom_in, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      "X${(40000 / _visibleRange).toStringAsFixed(1)}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Control buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _isStreaming ? _stopStreaming : null,
                      icon: Icon(Icons.stop, color: Colors.redAccent),
                      label: const Text('Остановить',
                          style: TextStyle(color: Colors.redAccent)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: !_isStreaming ? _resumeStreaming : null,
                      icon: Icon(Icons.play_arrow, color: Colors.green),
                      label: const Text('Продолжить',
                          style: TextStyle(color: Colors.green)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
