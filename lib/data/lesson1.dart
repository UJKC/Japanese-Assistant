import 'package:japanese_assistant/models/flashcard.dart';
import 'package:japanese_assistant/models/lesson.dart';
import 'package:japanese_assistant/models/unit.dart';

final lesson1 = Lesson(
  lessonNumber: 1,
  lessonTitle: 'Greetings & Basic Phrases',
  lessonPages: 'Genki I: p.1–15',
  slug: 'lesson-1',
  units: [
    Unit(
      title: 'Vocabulary',
      slug: 'vocabulary',
      items: [
        Flashcard(
          japanese: 'こんにちは',
          meaning: 'Hello',
          pronunciation: 'Konnichiwa',
        ),
        Flashcard(
          japanese: 'ありがとう',
          meaning: 'Thank you',
          pronunciation: 'Arigatou',
        ),
        Flashcard(
          japanese: 'さようなら',
          meaning: 'Goodbye',
          pronunciation: 'Sayounara',
        ),
        Flashcard(
          japanese: 'おはよう',
          meaning: 'Good morning',
          pronunciation: 'Ohayou',
        ),
        Flashcard(
          japanese: 'こんばんは',
          meaning: 'Good evening',
          pronunciation: 'Konbanwa',
        ),
      ],
    ),
    Unit(
      title: 'Kanji Readings',
      slug: 'kanji-readings',
      items: [
        Flashcard(
          japanese: '日',
          meaning: 'day; sun',
          pronunciation: 'nichi / hi',
        ),
        Flashcard(
          japanese: '人',
          meaning: 'person',
          pronunciation: 'hito / jin / nin',
        ),
        Flashcard(
          japanese: '学',
          meaning: 'study; learning',
          pronunciation: 'gaku / mana-bu',
        ),
      ],
    ),
  ],
);
