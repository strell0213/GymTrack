import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:flutter_application_1/ui/widgets/settingsFoods_model.dart';
import 'package:provider/provider.dart';

class SettingsFoodsWidget extends StatelessWidget {
  const SettingsFoodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final VM = context.watch<SettingsfoodsModel>();
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Настройки FoodTrack'),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: themeVM.isDarkTheme ? Colors.black : Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(controller: VM.weightController,),
              TextField(controller: VM.tallController,),
              TextField(controller: VM.oneProteinController,),
              TextField(controller: VM.oneFatsController,),
              TextField(controller: VM.oneCarControllet,),
              TextButton(onPressed: (){
                themeVM.saveFoods(
                  VM.weightController as double,
                  VM.tallController as double,
                  VM.oneProteinController as double,
                  VM.oneFatsController as double,
                  VM.oneCarControllet as double
                );
                Navigator.pop(context);
              }, child: Text('Сохранить'))
            ],
          ),
        )
      ),
    );
  }
}