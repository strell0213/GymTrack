import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            _WeightWidget(viewModal: viewModal),
            TextButton.icon(
              onPressed: () => viewModal.addGoal(context),
              icon: const Icon(Icons.add),
              label: const Text('Добавить'),
            ),
          ],
        ),
        
      ),
    );
  }
}

class _WeightWidget extends StatefulWidget {
  const _WeightWidget({
    required this.viewModal,
  });

  final GoalAddViewModal viewModal;

  @override
  State<_WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<_WeightWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.viewModal.weightController,
      onChanged: (value) {
        String str = widget.viewModal.weightController.text;
        if(str == "")
        {
          setState(() {
            widget.viewModal.weightController.text=widget.viewModal.exercise.weight.toString();
          });
        }
        // else if(int.tryParse(str)! < widget.viewModal.exercise.weight)
        // {
        //   setState(() {
        //     widget.viewModal.weightController.text=widget.viewModal.exercise.weight.toString();
        //   });
        // }
        else if(str.length > 1)
        {
          if(str[0] == "0")
          {
            str = str.substring(1, str.length);
          }
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // <-- только цифры
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Введите желаемый вес',
      ),
    );
  }
}