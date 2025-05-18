import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SwitchListTile(
          value: themeVM.isDarkTheme,
          title: Text('Темная тема'),
          onChanged: (value) {
            themeVM.toggleTheme();
          },
        ),
      ),
    );
  }
}