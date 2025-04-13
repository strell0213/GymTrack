import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/add_model.dart';
import 'package:flutter_application_1/ui/widgets/add_widget.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:provider/provider.dart';

class Mainwidget extends StatelessWidget {
  const Mainwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, // 7 дней недели
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('GymTrack')),
          bottom: const TabBar(
            isScrollable: true,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => AddViewModel(),
                  child: AddWidget(),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _ExerciseListBody extends StatelessWidget {
  final String day;
  const _ExerciseListBody({required this.day});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExerciseViewModel>().state;

    final filteredExercises = state.exercises.where((e) => e.day == day).toList();

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Ошибка: ${state.errorMessage}'));
    }

    if (filteredExercises.isEmpty) {
      return const Center(child: Text('Нет упражнений'));
    }

    return ListView.builder(
      itemCount: filteredExercises.length,
      padding: const EdgeInsets.all(10),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (BuildContext context, int index){
        final exercise = filteredExercises[index];
        // return _ExerciseListRowWidget(exercise: exercise, indexExercise: index);
    
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white, // Цвет фона
            border: Border.all(color: Colors.grey, width: 2), // Обводка
            borderRadius: BorderRadius.circular(12), // Скруглённые углы
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Тень
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              exercise.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Повторений'),
                    const SizedBox(width: 25),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        exercise.count-=1;
                        context.read<ExerciseViewModel>().updateExercise(exercise);
                      },
                    ),
                    Text(exercise.count.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        exercise.count+=1;
                        context.read<ExerciseViewModel>().updateExercise(exercise);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Вес'),
                    const SizedBox(width: 83),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        exercise.weight-=1;
                        context.read<ExerciseViewModel>().updateExercise(exercise);
                      },
                    ),
                    Text(exercise.weight.toString()), // поправил на вес
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        exercise.weight+=1;
                        context.read<ExerciseViewModel>().updateExercise(exercise);
                      },
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<ExerciseViewModel>().deleteExercise(index);
              },
            ),
          ),
        );
      }
    );
  }
}

