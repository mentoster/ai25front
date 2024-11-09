// side_menu.dart
import 'package:ai25front/cardio_client.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isCollapsed ? 70 : 200,
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Кнопка для сворачивания/разворачивания меню
          IconButton(
            icon: Icon(
              isCollapsed ? Icons.arrow_forward : Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
          ),
          // Элементы меню
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.save,
                  text: isCollapsed ? '' : 'Сохранить файл',
                  onTap: () async {
                    String? selectedDirectory =
                        await FilePicker.platform.getDirectoryPath();
                    if (selectedDirectory != null) {
                      CardioClient().setWorkingDirectory(selectedDirectory);
                      print('Выбрана директория: $selectedDirectory');
                    }
                  },
                ),
                _buildMenuItem(
                  icon: Icons.file_present,
                  text: isCollapsed ? '' : 'Выбрать файл для обработки',
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      String? selectedFile = result.files.single.path;
                      if (selectedFile != null) {
                        CardioClient().setFileToProcess(selectedFile);
                        print('Выбран файл: $selectedFile');
                      }
                    }
                  },
                ),
                // Добавьте дополнительные элементы меню здесь
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: isCollapsed
          ? null
          : Text(text, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
