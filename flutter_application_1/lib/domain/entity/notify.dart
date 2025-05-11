import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/services/exercise_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class Notify 
{
  final notifacationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInit = false;

  bool get isInit => _isInit;

  Future<void> init() async{
    if(_isInit) return;

    const initSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS
    );

    await notifacationPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notification',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notifacationPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await notifacationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails(), 
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> GenerateNotifyForWeek(ExerciseService services) async
  {
    final list = await services.loadExercises();

    var filter = list.where((e) => e.day == "mon").toList();
    List<String> strs = [];
    bool check=false;
    if(filter.isEmpty) return;

    for(int i = 0; i < filter.length; i++)
    {
      if(strs.isEmpty) strs.add(filter[i].typeExercice);

      for(var str in strs)
      {
        if(str == filter[i].typeExercice) check=true; 
      }

      if(!check) strs.add(filter[i].typeExercice);
      else {
        check = false;
      }
    }

    String title = "Пора в зал!";
    String body = "Сегодня у нас - ";
    for (int i = 0; i < strs.length; i++)
    {
      body += strs[i];
      if(i + 1 == strs.length) body += "и";
    }

    // scheduleNotification(
    //   id: 0, 
    //   title: title, 
    //   body: body, 
    //   scheduledDate: scheduledDate
    // );
  }
}