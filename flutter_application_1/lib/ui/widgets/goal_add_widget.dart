import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/goal_add_model.dart';
import 'package:provider/provider.dart';

class GoalAddWidget extends StatelessWidget {
  const GoalAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModal = context.watch<GoalAddViewModal>();
    return Scaffold(
      appBar: AppBar(title: Text('Добавьте цель'),),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: viewModal.nameController,
              decoration: const InputDecoration(
                  hintText: 'Введите название цели',
                  border: OutlineInputBorder(),
              ),
            ),
            TextButton.icon(
              onPressed: () => viewModal.addGoal(),
              icon: const Icon(Icons.add),
              label: const Text('Добавить'),
            ),
          ],
        ),
        
      ),
    );
  }
}