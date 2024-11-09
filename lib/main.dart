import 'package:ai25front/cardiogram_chart.dart';
import 'package:ai25front/theme/theme.dart';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isExeStarted = false;

  @override
  void initState() {
    super.initState();
    _runExeOnStartup();
  }

  Future<void> _runExeOnStartup() async {
    try {
      // Укажите путь к вашему .exe файлу
      final exePath = 'exe/main.exe';

      // Ожидание запуска .exe
      final process = await Process.start(
        exePath,
        [],
        mode: ProcessStartMode.detached,
      );

      // Пауза, чтобы убедиться, что процесс успел стартовать
      await Future.delayed(const Duration(seconds: 2));

      if (process.pid != null) {
        setState(() {
          _isExeStarted = true;
        });
        print("Приложение запущено.");
      }
    } catch (e) {
      print("Ошибка при запуске приложения: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крыски',
      theme: mytheme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Кардиограмма')),
        body: Center(
          child: _isExeStarted
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 2.0,
                    child: CardiogramChart(),
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
