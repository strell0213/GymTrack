import 'package:flutter_application_1/domain/services/exercise_service.dart';
import 'package:flutter_application_1/domain/services/not_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class Not
{
  int _id;
  String _date;
  int _type; //1 - уведомления по типам упражнения

  Not(this._id, this._date, this._type);
  Map<String, dynamic> toJson() => {
        'id': _id,
        'date': _date,
        'type': _type
      };

  factory Not.fromJson(Map<String, dynamic> json) {
    return Not(
      json['id'],
      json['date'],
      json['type']
    );
  }

  int get id => _id;
  String get date => _date;
  int get type => _type;
}

class Notify 
{
  final notifacationPlugin = FlutterLocalNotificationsPlugin();
  final NotService notService = NotService();

  bool _isInit = false;

  bool get isInit => _isInit;

  Future<void> init() async{
    if(_isInit) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

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
  }) async 
  {
    var date = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      8,
      0,
    );
    await notifacationPlugin.zonedSchedule(
      id,
      title,
      body,
      date,
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: 'payload'
    );
  }

  Future<void> GenerateNotifyForWeek(ExerciseService services) async
  {
    notService.deleteOldNot();
    for(int i = 1; i <= 7; i++)
    {
      final strs = await services.getTypesStr(i);

      if(strs==null) continue;

      String title = "Пора в зал!";
      String body = "Сегодня у нас - ";
      for (int i = 0; i < strs.length; i++)
      {
        body += strs[i];
        if(i + 1 != strs.length) body += "и";
      }

      Not not = Not(await notService.newID(), getNextWeekday(i).toString(), 1);
      if (await notService.checkNot(not) == false) continue;
      notService.addNot(not);

      await scheduleNotification(
        id: not.id, 
        title: title, 
        body: body, 
        scheduledDate: DateTime.parse(not.date)
      );
    }
  }

  Future<void> testNotification() async {
    final now = tz.TZDateTime.now(tz.local);
    final schedule = now.add(const Duration(seconds: 5)); // Через 5 секунд

    await notifacationPlugin.zonedSchedule(
      1,
      'Test title',
      'Test body',
      schedule,
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: 'test_payload',
    );
  }


  DateTime getNextWeekday(int weekday) {
    final now = DateTime.now();
    final daysUntil = (weekday - now.weekday + 7) % 7;
    final nextDate = now.add(Duration(days: daysUntil == 0 ? 7 : daysUntil));

    return DateTime(
      nextDate.year,
      nextDate.month,
      nextDate.day,
      8, // 08:00 утра
      0,
    );
  }

}