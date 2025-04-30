import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/domain/services/history_service.dart';
import 'package:flutter_application_1/ui/widgets/detail_model.dart';
import 'package:flutter_application_1/ui/widgets/goal_model.dart';
import 'package:flutter_application_1/ui/widgets/goal_widget.dart';
import 'package:flutter_application_1/ui/widgets/statistic_model.dart';
import 'package:flutter_application_1/ui/widgets/statistic_widget.dart';
import 'package:flutter_application_1/ui/widgets/themeviewmodel.dart';
import 'package:provider/provider.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 48, height: 48,),
            Expanded(child: Center(child: Text(viewModel.exercise.name))),
            IconButton(
              onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => GoalViewModal(viewModel.exercise),
                        child: MainGoalWidget(),
                      ),
                    ),
                  );
              }, 
              icon: Icon(Icons.star_outline_sharp)
            ),
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => StatisticViewModel(viewModel.exercise, HistoryService()),
                        child: StatisticWidget(),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.analytics_outlined)
              )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: InfoDetailWidget(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(35),
        child: ElevatedButton(
          onPressed: () {
            viewModel.saveAll(context);
            Navigator.pop(context);
          }, 
          child: Text('Сохранить', 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: themeVM.isDarkTheme ? Colors.white : Colors.black,// Цвет фона
              fontSize: 18
            ),
          )
        ),
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
        WeightCountWidget(viewModel: viewModel),
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
          // textAlignVertical: TextAlignVertical.top, // <-- Важно!
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Как делать упражнение?',
            alignLabelWithHint: true, // <-- Это нужно, чтобы label не плавал в центре
          ),
        ),
        SizedBox(height: 5,),
      ],
    );
  }
}

class WeightCountWidget extends StatelessWidget {
  const WeightCountWidget({
    super.key,
    required this.viewModel,
  });
  final DetailViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: viewModel.weightController,
            onTap: () {
              viewModel.weightController.text == "0" ? viewModel.weightController.text="" : viewModel.weightController.text=viewModel.weightController.text;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // <-- только цифры
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Введите вес',
            ),
          ),
        ),
        SizedBox(width: 5,),
        Expanded(
          child: TextField(
            controller: viewModel.countController,
            onTap: () {
              viewModel.countController.text == "0" ? viewModel.countController.text="" : viewModel.countController.text=viewModel.countController.text;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // <-- только цифры
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Введите повторения',
            ),
          ),
        )
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
      ],
    );
  }
}