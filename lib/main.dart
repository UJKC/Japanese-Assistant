import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:japanese_assistant/models/quiz_result.dart';
import 'models/flashcard.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';
// ✅ Import Android intent

final FlutterTts flutterTts = FlutterTts();

// ✅ Add this function
Future<bool> requestExactAlarmPermission() async {
  if (!Platform.isAndroid) return true; // iOS or others, continue

  var box = await Hive.openBox('app_settings');
  bool? granted = box.get('exact_alarm_granted', defaultValue: false);

  if (granted == true) {
    // Already granted before
    return true;
  }

  // Do NOT open settings if not granted yet
  // Only allow user to grant manually from settings
  return false;
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FlashcardAdapter());
  await Hive.openBox<Flashcard>('flashcards');
  Hive.registerAdapter(QuizResultAdapter());
  await Hive.openBox<QuizResult>('quiz_results');

  // Initialize TTS
  await flutterTts.setLanguage("ja-JP");
  await flutterTts.setSpeechRate(0.4);
  await flutterTts.setPitch(1.0);

  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.initNotification();

  // ✅ Request Notification Permission
  bool? permissionGranted = await notificationService.requestPermission();

  if (permissionGranted!) {
    // ✅ Schedule periodic notifications only if granted
    await notificationService.schedulePeriodicNotification(
      title: "Study Reminder 🇯🇵",
      body: "Time to practice your Japanese flashcards!",
      interval: RepeatInterval.daily,
    );
  } else {
    // ❌ Permission denied — handle gracefully
    print("User denied notification permission. Notifications disabled.");
  }

  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japanese Flashcards',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
