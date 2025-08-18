Here’s your updated **README.md** file with **daily notification reminders** added to the feature list and future plans:

---

# 🇯🇵 Japanese Flashcard App

A minimalist, offline-first flashcard app built with Flutter to help users learn Japanese vocabulary daily. Designed for simplicity, modularity, and future extensibility (e.g., voice playback, user-added words, score tracking, notifications).

---

## 📱 Features

- ✅ Daily flashcard learning (e.g., 10 words/day)
- ✅ Quiz mode to test vocabulary
- ✅ Offline support with local storage
- ✅ Preloaded vocabulary set
- ✅ User-added custom words (stored separately)
- ✅ Daily notification reminders to study
- 🚧 Future-ready voice playback (TTS)
- 🚧 Future score tracking
- 🚫 No login, no cloud sync

---

## 🧱 Tech Stack

- **Flutter**: UI and app logic
- **Hive**: Local storage for flashcards and user data
- **flutter_tts** *(optional)*: Text-to-speech for Japanese pronunciation
- **flutter_local_notifications**: Daily reminders

---

## 📦 Project Structure

```
lib/
├── main.dart
├── models/
│   ├── flashcard.dart
│   └── user_word.dart
├── services/
│   ├── storage_service.dart
│   ├── tts_service.dart
│   └── notification_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── flashcard_screen.dart
│   └── quiz_screen.dart
├── widgets/
│   └── flashcard_widget.dart
└── utils/
    └── constants.dart
```

---

## 🗂️ Data Models

### Flashcard

```dart
class Flashcard {
  final String japanese;
  final String meaning;
  final String pronunciation;
  bool isLearned;
}
```

### UserWord

```dart
class UserWord {
  final String japanese;
  final String meaning;
  final String pronunciation;
}
```

---

## 🔔 Daily Notification Reminder

To enable daily reminders:

```yaml
dependencies:
  flutter_local_notifications: ^16.1.0
```

Example setup:

```dart
final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> scheduleDailyReminder() async {
  await notificationsPlugin.zonedSchedule(
    0,
    'Study Japanese!',
    'Your daily flashcards are ready.',
    _nextInstanceOfTenAM(),
    const NotificationDetails(...),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}
```

---

## 🔊 Voice Playback (Future Feature)

```yaml
dependencies:
  flutter_tts: ^3.6.3
```

```dart
final FlutterTts flutterTts = FlutterTts();
await flutterTts.setLanguage("ja-JP");
await flutterTts.speak("こんにちは");
```

---

## 🛠️ How to Run

1. Clone the repo
2. Run `flutter pub get`
3. Run `flutter run` on your device/emulator

---

## 📅 Development Timeline

| Week | Focus |
|------|-------|
| Week 1 | UI setup, navigation, storage integration |
| Week 2 | Flashcard logic, quiz mode, user word input |
| Week 3 | Modularization, voice prep, notifications, final polish |

---

## 📌 Future Plans

- 🔊 Voice playback for flashcards
- 🧠 Score tracking and progress history
- 📤 Export/import user words
- 🌙 Dark mode
- 🗂️ Word categories and tags
- 🔔 Customizable notification time

---

Let me know if you'd like to include:
- Screenshots or demo GIFs
- Contribution guidelines
- License section
- GitHub Actions or CI setup

Would you like me to scaffold the notification service or generate the initial Flutter files next?
