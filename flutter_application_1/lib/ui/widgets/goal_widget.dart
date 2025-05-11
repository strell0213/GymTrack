import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/goal.dart';
import 'package:flutter_application_1/domain/services/exercise_service.dart';
import 'package:flutter_application_1/ui/widgets/goal_add_model.dart';
import 'package:flutter_application_1/ui/widgets/goal_add_widget.dart';
import 'package:flutter_application_1/ui/widgets/goal_model.dart';
import 'package:flutter_application_1/ui/widgets/themeviewmodel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MainGoalWidget extends StatelessWidget {
  const MainGoalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GoalViewModal>().state;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Center(child: Text('Цели'))),
            IconButton(
              onPressed: () async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => GoalAddViewModal(state.exercise, ExerciseService()),
                      child: GoalAddWidget(),
                    ),
                  ),
                ).then((_) => Navigator.pop(context));
              }, 
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
    final GVM = context.watch<GoalViewModal>();
    final state = GVM.state;
    final themeVM = Provider.of<ThemeViewModel>(context);

    final exercise = state.exercise;
    final goals = exercise.goals;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Ошибка: ${state.errorMessage}'));
    }

    if(goals.isEmpty){
      return Center(child: Text('Список целей пуст'));
    }

    return ListView.builder(
      itemCount: goals.length,
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
                  color: exercise.weight >= goal.targetWeight ? Colors.green : Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          child: 
          Slidable(
            key: ValueKey(goal.idGoal),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    GVM.deleteGoal(goal);
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Удалить',
                ),
              ],
            ),
            child: ListTile(
              title: _TitleWidget(goal: goal),
              subtitle: Row(
                children: [
                  SizedBox(height: 50,),
                  Expanded(child: _GoalProgressBar(exercise: exercise, goal: goal))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    required this.goal,
  });

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Text(goal.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
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
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${exercise.weight} / ${goal.targetWeight} кг'), // Текущие значения
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: (exercise.weight / goal.targetWeight).clamp(0.0, 1.0), // Ограничиваем от 0 до 1
          backgroundColor: Colors.grey[300],
          color: themeVM.isDarkTheme ? Colors.yellow : Colors.deepOrange,
          minHeight: 8,
        ),
      ],
    );
  }
}