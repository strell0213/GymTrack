import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/add_widget.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:provider/provider.dart';

class Mainwidget extends StatelessWidget {
  const Mainwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Kachalka'),),),
      body: Column(
        children: [
          _ExerciseListBody()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddWidget()));
        },
        child: const Icon(Icons.add),
      ),
    ); 
  }
}
class _ExerciseListBody extends StatelessWidget {
  const _ExerciseListBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExerciseViewModel>().state;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Ошибка: ${state.errorMessage}'));
    }

    if (state.exercises.isEmpty) {
      return const Center(child: Text('Нет упражнений'));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: state.exercises.length,
        padding: const EdgeInsets.all(10),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (BuildContext context, int index){
          final exercise=state.exercises[index];
          // return _ExerciseListRowWidget(exercise: exercise, indexExercise: index);

          return ListTile(
            title: Text(exercise.name),
            subtitle: Text('${exercise.count} повторений, ${exercise.weight} кг'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<ExerciseViewModel>().deleteExercise(index);
              },
            ),
          );
        }
      ),
    );
  }
}

