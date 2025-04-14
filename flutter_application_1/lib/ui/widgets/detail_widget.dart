import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:provider/provider.dart';

class DetailWidget extends StatelessWidget {
  final Exercise curExercise;
  const DetailWidget({super.key, required this.curExercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(curExercise.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: InfoDetailWidget(curExercise: curExercise,),
      ),
    );
  }
}


class InfoDetailWidget extends StatefulWidget {
  final Exercise curExercise;
  const InfoDetailWidget({super.key, required this.curExercise});

  @override
  State<InfoDetailWidget> createState() => _InfoDetailWidgetState();
}

class _InfoDetailWidgetState extends State<InfoDetailWidget> {
  final TextEditingController _howDidController = TextEditingController();

  void initTexts()
  {
    _howDidController.text = widget.curExercise.howDid;
  }

  void _updateHowDid() {
    final mm = context.read<ExerciseViewModel>();
    widget.curExercise.howDid = _howDidController.text;

    mm.updateExercise(widget.curExercise);
  }



  @override
  Widget build(BuildContext context) {
    initTexts();
    return Column(
      children: [
        TextField(
          maxLines: 10,
          controller: _howDidController,
          decoration: const InputDecoration(
            hintText: 'Как делать упражнение?',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _updateHowDid,
            icon: const Icon(Icons.save),
            label: const Text('Сохранить'),
          ),
        ),
        SizedBox(height: 25,),
        // TextField(
        //   maxLines: 10,
        //   controller: _howDidController,
        //   decoration: const InputDecoration(
        //     hintText: 'Как делать упражнение?',
        //     border: OutlineInputBorder(),
        //   ),
        // ),
        // SizedBox(height: 5,),
        // Container(
        //   alignment: Alignment.centerLeft,
        //   child: TextButton.icon(
        //     onPressed: _updateHowDid,
        //     icon: const Icon(Icons.save),
        //     label: const Text('Сохранить'),
        //   ),
        // ),
      ],
    );
  }
}