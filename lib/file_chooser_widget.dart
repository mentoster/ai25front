// file_chooser_widget.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ai25front/cardio_client.dart';
// file_chooser_widget.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ai25front/cardio_client.dart';

class FileChooserWidget extends StatefulWidget {
  final Function(String)
      onFileSelected; // Колбэк для передачи выбранного файла родителю

  FileChooserWidget({required this.onFileSelected});

  @override
  _FileChooserWidgetState createState() => _FileChooserWidgetState();
}

class _FileChooserWidgetState extends State<FileChooserWidget> {
  bool isLoading = false;

  Future<void> _chooseFile() async {
    setState(() {
      isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      String selectedFile = result.files.single.path!;
      CardioClient().setFileToProcess(selectedFile);
      print('Selected file: $selectedFile');

      // Передаем результат в родительский виджет
      widget.onFileSelected(selectedFile);

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator()
            else ...[
              SizedBox(height: 20),
              Text(
                'Welcome! Please choose a file to continue.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(
                Icons.file_present,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _chooseFile,
                icon: Icon(Icons.upload_file),
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    'Choose File',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Next widget that shows up after the file is selected
class NextWidget extends StatelessWidget {
  const NextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Файл выбран! Загружаем...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}