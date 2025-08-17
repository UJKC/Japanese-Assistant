import 'package:japanese_assistant/models/flashcard.dart';
import 'package:japanese_assistant/models/lesson.dart';
import 'package:japanese_assistant/models/unit.dart';

final lesson20 = Lesson(
  lessonNumber: 20,
  lessonTitle: 'Mary Goes Shopping',
  lessonPages: 'Genki II: p.180-205',
  slug: 'lesson-20',
  units: [
    Unit(
      title: 'Vocabulary',
      slug: 'vocabulary',
      items: [
        Flashcard(
          japanese: 'アニメ',
          meaning: 'animation',
          pronunciation: 'anime',
        ),
        Flashcard(
          japanese: 'しょうせつ',
          meaning: 'novel',
          pronunciation: 'shousetsu',
        ),
        Flashcard(
          japanese: 'しゅみ',
          meaning: 'hobby; pastime',
          pronunciation: 'shumi',
        ),
        Flashcard(japanese: 'つき', meaning: 'moon', pronunciation: 'tsuki'),
        Flashcard(
          japanese: 'うちゅうじん',
          meaning: 'space alien',
          pronunciation: 'uchuujin',
        ),
        // ...continue for all items
      ],
    ),
    Unit(
      title: 'Kanji Readings',
      slug: 'kanji-readings',
      items: [
        Flashcard(japanese: '皿', meaning: 'さら', pronunciation: 'sara'),
        Flashcard(japanese: '声', meaning: 'こえ', pronunciation: 'koe'),
        Flashcard(japanese: 'お茶', meaning: 'おちゃ', pronunciation: 'ocha'),
        // ...etc
      ],
    ),
  ],
);
