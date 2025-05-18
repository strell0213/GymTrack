import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/notify.dart';
import 'package:flutter_application_1/domain/services/exercise_service.dart';
import 'package:flutter_application_1/domain/services/history_service.dart';
import 'package:flutter_application_1/ui/widgets/main_model.dart';
import 'package:flutter_application_1/ui/widgets/main_widget.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  final notify = Notify();
  notify.init();
  
  final today = DateTime.now();
  if (today.weekday == DateTime.sunday || today.weekday == DateTime.friday) {
    notify.GenerateNotifyForWeek(ExerciseService());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExerciseViewModel(ExerciseService(), HistoryService())),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const MyAppWidget(),
    );
  }
}

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);

    return MaterialApp(
      title: 'GymTrack',
      themeMode: themeViewModel.currentThemeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Mainwidget(),
    );
  }
}
