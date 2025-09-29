import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initNotifications() {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse,
  ) {}

  static void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) {}

  static void showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          priority: Priority.max,
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await setTimeZone();
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> setTimeZone() async {
    tz.initializeTimeZones();
    final TimezoneInfo timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    final String currentTimeZone = timeZoneInfo.identifier;
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }
}
