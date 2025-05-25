import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:flutter_application_1/ui/widgets/add_food_model.dart';
import 'package:provider/provider.dart';

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final VM = context.watch<AddFoodModel>();
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая позиция'),
      ),
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextField(controller: VM.nameController,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Наименование продукта',
                    alignLabelWithHint: true, // <-- Это нужно, чтобы label не плавал в центре
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: VM.caloriesController,
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Калорийность, гр',
                    ),
                ),
                SizedBox(height: 15,),
                TextField(controller: VM.proteinsController,
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Белки, гр',
                    ),
                ),
                SizedBox(height: 15,),
                TextField(controller: VM.fatsController,
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Жиры, гр',
                    ),
                ),
                SizedBox(height: 15,),
                TextField(controller: VM.carbohydratesController,
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Углеводы, гр',
                    ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: () async{
                    await VM.addNewFood();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shadowColor: Colors.grey,
                ), 
                  child: Text('Добавить'),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}