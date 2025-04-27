import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/goal.dart';
import 'package:flutter_application_1/ui/widgets/goal_model.dart';
import 'package:flutter_application_1/ui/widgets/themeviewmodel.dart';
import 'package:provider/provider.dart';

class MainGoalWidget extends StatelessWidget {
  const MainGoalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Center(child: Text('Цели'))),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.add)
            )
          ],
        ),
      ),
      body: _GoalListWidget(),
    );
  }
}

class _GoalListWidget extends StatelessWidget {
  const _GoalListWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GoalViewModal>().state;
    final themeVM = Provider.of<ThemeViewModel>(context);

    final exercise = state.exercise;
    final goals = exercise.goals;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Ошибка: ${state.errorMessage}'));
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        final goal = goals[index];
        return Container(
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
          child: ListTile(
            title: Text(goal.name),
            subtitle: Row(
              children: [
                _GoalProgressBar(exercise: exercise, goal: goal),
              ],
            ),
          ),
        );
      }
    );
  }
}

class _GoalProgressBar extends StatelessWidget {
  const _GoalProgressBar({
    required this.exercise,
    required this.goal,
  });

  final Exercise exercise;
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${exercise.weight} / ${goal.targetWeight} кг'), // Текущие значения
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: (exercise.weight / goal.targetWeight).clamp(0.0, 1.0), // Ограничиваем от 0 до 1
          backgroundColor: Colors.grey[300],
          color: Colors.yellow,
          minHeight: 8,
        ),
      ],
    );
  }
}