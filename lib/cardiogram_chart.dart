import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class CardiogramChart extends StatefulWidget {
  const CardiogramChart({super.key});

  @override
  _CardiogramChartState createState() => _CardiogramChartState();
}

class _CardiogramChartState extends State<CardiogramChart> {
  List<FlSpot> cardiogramData = [];
  Timer? _dataTimer;
  final Random _random = Random();
  String? _outputDirectory;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startDataTimer();
  }

  void _initializeData() {
    // Начальные точки
    cardiogramData = List.generate(10, (index) => FlSpot(index.toDouble(), 0));
  }

  void _startDataTimer() {
    // Генерация новых точек кардиограммы каждые 500 миллисекунд
    _dataTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // Генерируем случайное значение для нового пика
      double yValue = _random.nextBool() ? 2 : -1; // Генерация случайных пиков
      setState(() {
        cardiogramData.add(FlSpot(cardiogramData.length.toDouble(), yValue));

        // Оставляем последние 10 точек
        if (cardiogramData.length > 10) {
          cardiogramData.removeAt(0);
          // Обновляем индексы для плавного перехода
          for (int i = 0; i < cardiogramData.length; i++) {
            cardiogramData[i] = FlSpot(i.toDouble(), cardiogramData[i].y);
          }
        }
      });
    });
  }

  void _stopDataTimer() {
    // Остановка таймера
    _dataTimer?.cancel();
  }

  void _pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      setState(() {
        _outputDirectory = selectedDirectory;
      });
    }
  }

  void _saveToFile() async {
    if (_outputDirectory != null) {
      String filePath = '$_outputDirectory/cardiogram_data.txt';
      File file = File(filePath);
      List<String> dataStrings =
          cardiogramData.map((spot) => '${spot.x}, ${spot.y}').toList();
      await file.writeAsString(dataStrings.join('\n'));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные сохранены в $filePath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Пожалуйста, выберите директорию для сохранения.')),
      );
    }
  }

  @override
  void dispose() {
    _dataTimer?.cancel();
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
              maxX: 9,
              minY: -2,
              maxY: 4,
              titlesData: FlTitlesData(
                show: false, // Отключаем заголовки осей
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
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: false, // Убираем нижнюю заливку
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _stopDataTimer,
                child: const Text('Стоп'),
              ),
              ElevatedButton(
                onPressed: _pickDirectory,
                child: const Text('Выбрать директорию'),
              ),
              ElevatedButton(
                onPressed: _saveToFile,
                child: const Text('Сохранить файл'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
