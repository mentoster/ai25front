import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CardiogramChart extends StatefulWidget {
  const CardiogramChart({super.key});

  @override
  _CardiogramChartState createState() => _CardiogramChartState();
}

class _CardiogramChartState extends State<CardiogramChart> {
  List<FlSpot> cardiogramData = [];
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startTimer();
  }

  void _initializeData() {
    // Начальные точки
    cardiogramData = List.generate(10, (index) => FlSpot(index.toDouble(), 0));
  }

  void _startTimer() {
    // Симуляция новых точек кардиограммы каждые 500 миллисекунд
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        // Генерируем случайное значение для нового пика
        double yValue =
            _random.nextBool() ? 2 : -1; // Генерация случайных пиков
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
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
    );
  }
}
