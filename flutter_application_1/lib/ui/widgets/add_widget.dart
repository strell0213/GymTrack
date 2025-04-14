import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/ui/widgets/add_model.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:provider/provider.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({super.key});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedDay;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addExercise() {
    final mm = context.read<ExerciseViewModel>();
    final am = context.read<AddViewModel>();

    final text = _searchController.text;
    final isValid = am.checkControllerText(text);

    if (selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите день недели!')),
      );
      return;
    }

    if (isValid) {
      mm.addExercise(Exercise(text, 0, 0, am.getDayForAdd(selectedDay),''));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Вы ничего не ввели!')),
      );
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавьте упражнение')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Введите название упражнения',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            DayDropdown(
              onChanged: (value) {
                selectedDay = value;
              },
            ),
            const SizedBox(height: 15),
            TextButton.icon(
              onPressed: _addExercise,
              icon: const Icon(Icons.add),
              label: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}


class DayDropdown extends StatefulWidget {
  final Function(String) onChanged;
  const DayDropdown({super.key, required this.onChanged});

  @override
  State<DayDropdown> createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  final List<String> _days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  String? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Выберите день недели',
        border: OutlineInputBorder(),
      ),
      value: _selectedDay,
      items: _days.map((day) {
        return DropdownMenuItem(
          value: day,
          child: Text(day),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDay = value;
        });
        if (value != null) {
          widget.onChanged(value);
        }
      },
    );
  }
}
