import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/pages/reminder_datails_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._privateConstructor();

  static final NotificationService instance =
      NotificationService._privateConstructor();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize({
    required GlobalKey<NavigatorState> navigatorKey,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final reminderId = response.payload;
        if (reminderId == null) return;

        final box = Hive.box<ReminderModel>(kReminderBox);
        final reminders = box.values.where((r) => r.id == reminderId).toList();
        if (reminders.isEmpty) return;

        navigatorKey.currentState?.pushNamed(
          ReminderDatailsPage.id,
          arguments: reminders.first,
        );
      },
    );
  }

  Future<String?> getInitialNotificationPayload() async {
    final details = await _notificationsPlugin
        .getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      return details?.notificationResponse?.payload;
    }
    return null;
  }

  // Test methods ____________________________________________________________________________
  Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      id: 0,
      title: 'Test Title',
      body: 'This is a test notification',
      notificationDetails: details,
    );
  }

  Future<void> scheduleTestNotification() async {
    final scheduledTime = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(minutes: 5));
    print("Notification scheduled at: $scheduledTime");

    await _notificationsPlugin.zonedSchedule(
      id: 1,
      title: 'Scheduled Title',
      body: 'This notification was scheduled',
      scheduledDate: scheduledTime,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
  //_________________________________________________________________________________________________

  // ======= Weekly Repeat Notification methods =======

  Future<void> scheduleReminderNotifications(ReminderModel reminder) async {
    for (int day in reminder.days) {
      await _scheduleWeeklyNotification(
        id: _generateId(reminderId: reminder.id, day: day),
        title: reminder.title,
        body: reminder.note ?? 'Time for your reminder!',
        day: day,
        hour: reminder.hours,
        minute: reminder.minutes,
        payload: reminder.id,
      );
    }
  }

  Future<void> cancelReminderNotifications(ReminderModel reminder) async {
    for (int day in reminder.days) {
      await _notificationsPlugin.cancel(
        id: _generateId(reminderId: reminder.id, day: day),
      );
    }
  }

  Future<void> _scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int day,
    required int hour,
    required int minute,
    required String payload,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      payload: payload,
      scheduledDate: _nextInstanceOfDayTime(
        day: day,
        hour: hour,
        minute: minute,
      ),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _nextInstanceOfDayTime({
    required int day,
    required int hour,
    required int minute,
  }) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduledDate.weekday != day || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  int _generateId({required String reminderId, required int day}) {
    return reminderId.hashCode + day;
  }
}
