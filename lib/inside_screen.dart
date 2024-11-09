import 'package:ai25front/file_chooser_widget.dart';
import 'package:ai25front/multi_cardiogram_chart.dart';
import 'package:flutter/material.dart';

class InsideScreen extends StatefulWidget {
  const InsideScreen({super.key});

  @override
  _InsideScreenState createState() => _InsideScreenState();
}

class _InsideScreenState extends State<InsideScreen> {
  String? selectedFilePath;

  void _handleFileSelected(String filePath) {
    setState(() {
      selectedFilePath = filePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: selectedFilePath == null
          ? FileChooserWidget(onFileSelected: _handleFileSelected)
          : MultiCardiogramChart(),
    );
  }
}

class NextWidget extends StatelessWidget {
  final String selectedFilePath;

  NextWidget({required this.selectedFilePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'File selected: $selectedFilePath',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
