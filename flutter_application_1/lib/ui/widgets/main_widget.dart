import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/goal.dart';
import 'package:flutter_application_1/ui/dialogs/dialogs.dart';
import 'package:flutter_application_1/ui/widgets/add_model.dart';
import 'package:flutter_application_1/ui/widgets/add_widget.dart';
import 'package:flutter_application_1/ui/widgets/detail_model.dart';
import 'package:flutter_application_1/ui/widgets/detail_widget.dart';
import 'package:flutter_application_1/ui/widgets/food_model.dart';
import 'package:flutter_application_1/ui/widgets/food_widget.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:flutter_application_1/ui/widgets/settings_widget.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:provider/provider.dart';

DialogClass dialog = DialogClass();

class Mainwidget extends StatelessWidget {
  const Mainwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseViewModel = context.watch<ExerciseViewModel>();
    return DefaultTabController(
      length: 7, // 7 дней недели
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => SettingsWidget(),
                    )
                  );
                }, 
                icon: Icon(Icons.settings)
              ),
              SizedBox(width: 48, height: 48,),
              Expanded(child: Center(child: Text('GymTrack'))),
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => FoodModel(),
                        child: FoodWidget(),
                      ),
                    ),
                  );
                }, 
                icon: Icon(Icons.fastfood)
              ),
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => AddViewModel(exerciseViewModel),
                        child: AddWidget(),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.add)
              )
            ],
          ),
          bottom: const TabBar(
            isScrollable: false,
            tabs: [
              Tab(text: 'Пн'),
              Tab(text: 'Вт'),
              Tab(text: 'Ср'),
              Tab(text: 'Чт'),
              Tab(text: 'Пт'),
              Tab(text: 'Сб'),
              Tab(text: 'Вс'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ExerciseListBody(day: 'mon'),
            _ExerciseListBody(day: 'tue'),
            _ExerciseListBody(day: 'wed'),
            _ExerciseListBody(day: 'thu'),
            _ExerciseListBody(day: 'fri'),
            _ExerciseListBody(day: 'sat'),
            _ExerciseListBody(day: 'sun'),
          ],
        ),
      ),
    );
  }
}

class _ExerciseListBody extends StatefulWidget {
  final String day;
  const _ExerciseListBody({required this.day});

  @override
  State<_ExerciseListBody> createState() => _ExerciseListBodyState();
}

class _ExerciseListBodyState extends State<_ExerciseListBody> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExerciseViewModel>().state;
    final themeVM = Provider.of<ThemeViewModel>(context);
    final exerciseVM = context.watch<ExerciseViewModel>();

    final filteredExercises = state.exercises.where((e) => e.day == widget.day).toList();

    context.read<ExerciseViewModel>().checkReadyExersice(filteredExercises);
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Ошибка: ${state.errorMessage}'));
    }

    if (filteredExercises.isEmpty) {
      return const Center(child: Text('Нет упражнений'));
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      onReorder: (oldIndex, newIndex) {
        exerciseVM.reorderExercise(widget.day, oldIndex, newIndex);
      },
      children: [
        for (final exercise in filteredExercises)
          Container(
            key: ValueKey(exercise.id), // уникальный ключ
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: themeVM.isDarkTheme ? Colors.black : Colors.white,
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: exercise.isDone ? Colors.green : Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: _TitleListTile(exercise: exercise),
              subtitle: Row(
                children: [
                  _LeftButtons(exercise: exercise),
                  _RightButtons(exercise: exercise),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => DetailViewModel(exercise, exerciseVM),
                      child: DetailWidget(),
                    ),
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}

class _DownButtons extends StatelessWidget{
  const _DownButtons({
    required this.goal,
    required this.exercise
  });

  final Goal? goal;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Column(
      children: [
        Text(exercise.getActualText(goal!), style: TextStyle(color: themeVM.isDarkTheme ? Colors.yellow : Colors.deepOrange),),
      ],
    );
  }
}

class _LeftButtons extends StatelessWidget {
  const _LeftButtons({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CountWidget(exercise: exercise),
          _WeightWidget(exercise: exercise),
          SizedBox(height: 5,),
          Visibility(
            visible: exercise.getCountNotFinishGoals() != 0 ? true : false,
            child: _DownButtons(goal: exercise.getActualGoal(), exercise: exercise,)
          ),
        ],
      ),
    );
  }
}

class _RightButtons extends StatelessWidget {
  const _RightButtons({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 30.0),
      child: Transform.scale(
        scale: 1.5,
        child: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            dialog.showDeleteConfirmationDialog(context, () {
              context.read<ExerciseViewModel>().deleteExercise(exercise);
            });
          },
        ),
      ),
    );
  }
}

class _TitleListTile extends StatelessWidget {
  const _TitleListTile({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                exercise.name.length > 13 
                ? '${exercise.name.substring(0, 13)}..' 
                : exercise.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  exercise.typeExercice,
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: exercise.isDone,
              onChanged: (val){
                exercise.isDone = val!;
                if(val == false) {context.read<ExerciseViewModel>().deleteHistory(exercise);}
                else {context.read<ExerciseViewModel>().addHistory(exercise);}
              },
              shape: const CircleBorder(), // Круглая форма
            ),
          ),
        ),
      ],
    );
  }
}

class _WeightWidget extends StatelessWidget {
  const _WeightWidget({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Вес'),
        const SizedBox(width: 84),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (exercise.isDone) return;
            exercise.weight-=5;
            context.read<ExerciseViewModel>().updateExercise(exercise);
          },
        ),
        Text(exercise.weight.toString()), // поправил на вес
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (exercise.isDone) return;
            exercise.weight+=5;
            context.read<ExerciseViewModel>().updateExercise(exercise);
          },
        ),
      ],
    );
  }
}

class _CountWidget extends StatelessWidget {
  const _CountWidget({
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Повторений'),
        const SizedBox(width: 25),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () { 
            if(exercise.isDone) return;
            exercise.count-=5;
            context.read<ExerciseViewModel>().updateExercise(exercise);
          },
        ),
        Text(exercise.count.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if(exercise.isDone) return;
            exercise.count+=5;
            context.read<ExerciseViewModel>().updateExercise(exercise);
          },
        ),
      ],
    );
  }
}



