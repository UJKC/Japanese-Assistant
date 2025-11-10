// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() => _notificationService;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show instant notification
  Future<void> showInstantNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'flashcard_channel',
          'Flashcard Notifications',
          channelDescription: 'Reminders for flashcard learning',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // ✅ Periodic notification (e.g., every day at roughly the same time)
  Future<void> schedulePeriodicNotification({
    required String title,
    required String body,
    required RepeatInterval interval,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'periodic_channel',
          'Periodic Notifications',
          channelDescription: 'Periodic reminders for flashcard learning',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      title,
      body,
      interval, // e.g., RepeatInterval.daily
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  Future<bool?> requestPermission() async {
    final plugin = flutterLocalNotificationsPlugin;

    // iOS or macOS
    final iosPlugin = plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final macPlugin = plugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >();

    if (iosPlugin != null) {
      return await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (macPlugin != null) {
      return await macPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // Android 13+ (Tiramisu)
    final androidPlugin = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    // For platforms where permission is not required
    return true;
  }
}
