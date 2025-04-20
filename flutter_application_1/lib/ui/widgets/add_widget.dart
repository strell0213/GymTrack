import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/add_model.dart';
import 'package:provider/provider.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({super.key});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Добавьте упражнение')),
      body: _AddWidgetMain(viewModel: viewModel),
    );
  }
}

class _AddWidgetMain extends StatelessWidget {
  const _AddWidgetMain({
    required this.viewModel,
  });

  final AddViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          TextField(
            controller: viewModel.searchController,
            decoration: const InputDecoration(
              hintText: 'Введите название упражнения',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          DayDropdown(
            onChanged: (value) {
              viewModel.selectedDay = value;
            },
          ),
          const SizedBox(height: 30),
          TypeDropdown(
            onChanged: (value){
              viewModel.selectedType = value;
            }
          ),
          const SizedBox(height: 15),
          TextButton.icon(
            onPressed: () => viewModel.addExercise(context),
            icon: const Icon(Icons.add),
            label: const Text('Добавить'),
          ),
        ],
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

class TypeDropdown extends StatefulWidget {
  final Function(String) onChanged;
  const TypeDropdown({super.key, required this.onChanged});

  @override
  State<TypeDropdown> createState() => _TypeDropdownState();
}

class _TypeDropdownState extends State<TypeDropdown> {
  final List<String> _types = ['Без типа', 'Ноги', 'Руки', 'Плечи', 'Спина', 'Грудь', 'Кор (Пресс)'];
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = _types[0]; // Установка значения по умолчанию
    // Можно сразу передать его родителю, если нужно
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged(_selectedType!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Выберите тип упражнения',
        border: OutlineInputBorder(),
      ),
      value: _selectedType,
      items: _types.map((day) {
        return DropdownMenuItem(
          value: day,
          child: Text(day),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedType = value;
        });
        if (value != null) {
          widget.onChanged(value);
        }
      },
    );
  }
}