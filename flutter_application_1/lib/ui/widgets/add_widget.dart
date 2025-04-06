import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:provider/provider.dart';

class AddWidget extends StatelessWidget {
  AddWidget({super.key});
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавьте упражнение'),),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
          ),
          IconButton(
            onPressed: (){
              final vm = context.read<ExerciseViewModel>();
              vm.addExercise(Exercise(_searchController.text,0,0));
              Navigator.pop(context);
            }, icon: Icon(Icons.add)
          )
        ],
      ),
    );
  }
}