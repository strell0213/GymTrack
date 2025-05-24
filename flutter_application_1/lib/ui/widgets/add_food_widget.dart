import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/add_food_model.dart';
import 'package:provider/provider.dart';

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final VM = context.watch<AddFoodModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая позиция'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextField(controller: VM.nameController,),
            TextField(controller: VM.caloriesController,),
            TextField(controller: VM.proteinsController,),
            TextField(controller: VM.fatsController,),
            TextField(controller: VM.carbohydratesController,),
            TextButton(onPressed: () async{
              await VM.addNewFood();
              Navigator.pop(context);
            }, child: Text('добавить'))
          ],
        ),
      )
    );
  }
}