import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/ui/widgets/detail_model.dart';
import 'package:provider/provider.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.exercise.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: InfoDetailWidget(),
      ),
    );
  }
}


class InfoDetailWidget extends StatefulWidget {
  const InfoDetailWidget({super.key});

  @override
  State<InfoDetailWidget> createState() => _InfoDetailWidgetState();
}

class _InfoDetailWidgetState extends State<InfoDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();
    return Column(
      children: [
        NameWidget(viewModel: viewModel),
        SizedBox(height: 25,),
        CountWidget(viewModel: viewModel,),
        SizedBox(height: 25,),
        WeightWidget(viewModel: viewModel),
        SizedBox(height: 25,),
        HowDidWidget(viewModel: viewModel),
        SizedBox(height: 25,),
      ],
    );
  }
}

class HowDidWidget extends StatelessWidget {
  const HowDidWidget({
    super.key,
    required this.viewModel,
  });
  final DetailViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: 10,
          controller: viewModel.howDidController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Как делать упражнение?',
          ),
        ),
        SizedBox(height: 5,),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => viewModel.saveHowDid(context),
            icon: const Icon(Icons.save),
            label: const Text('Сохранить'),
          ),
        ),
      ],
    );
  }
}

class WeightWidget extends StatelessWidget {
  const WeightWidget({
    super.key,
    required this.viewModel,
  });
  final DetailViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: viewModel.weightController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // <-- только цифры
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Введите вес',
          ),
        ),
        SizedBox(height: 5,),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => viewModel.saveWeight(context),
            icon: const Icon(Icons.save),
            label: const Text('Сохранить'),
          ),
        ),
      ],
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.viewModel,
  });
  final DetailViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: viewModel.countController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // <-- только цифры
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Введите повторения',
          ),
        ),
        SizedBox(height: 5,),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => viewModel.saveCount(context),
            icon: const Icon(Icons.save),
            label: const Text('Сохранить'),
          ),
        ),
      ],
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.viewModel,
  });
  final DetailViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: viewModel.nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Введите наименование',
          ),
        ),
        SizedBox(height: 5,),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => viewModel.saveName(context),
            icon: const Icon(Icons.save),
            label: const Text('Сохранить'),
          ),
        ),
      ],
    );
  }
}