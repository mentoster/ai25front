import 'package:ai25front/CardiogramChart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Кардиограмма')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: AspectRatio(
              aspectRatio: 2.0,
              child: CardiogramChart(),
            ),
          ),
        ),
      ),
    );
  }
}
