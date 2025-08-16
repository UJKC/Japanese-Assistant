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
          frontSide: 'アニメ',
          backSide: 'animation',
          pronunciation: 'anime',
          japanese: '',
          meaning: '',
        ),
        Flashcard(
          frontSide: 'しょうせつ',
          backSide: 'novel',
          pronunciation: 'shousetsu',
          japanese: '',
          meaning: '',
        ),
        Flashcard(
          frontSide: 'しゅみ',
          backSide: 'hobby; pastime',
          pronunciation: 'shumi',
          japanese: '',
          meaning: '',
        ),
        Flashcard(
          frontSide: 'つき',
          backSide: 'moon',
          pronunciation: 'tsuki',
          japanese: '',
          meaning: '',
        ),
        Flashcard(
          frontSide: 'うちゅうじん',
          backSide: 'space alien',
          pronunciation: 'uchuujin',
          japanese: '',
          meaning: '',
        ),
        // ...continue for all items
      ],
    ),
    Unit(
      title: 'Kanji Readings',
      slug: 'kanji-readings',
      items: [
        Flashcard(
          frontSide: '皿',
          backSide: 'さら',
          pronunciation: 'sara',
          japanese: '',
          meaning: '',
        ),
        Flashcard(
          frontSide: '声',
          backSide: 'こえ',
          pronunciation: 'koe',
          japanese: '',
          meaning: '',
        ),
        Flashcard(
          frontSide: 'お茶',
          backSide: 'おちゃ',
          pronunciation: 'ocha',
          japanese: '',
          meaning: '',
        ),
        // ...etc
      ],
    ),
  ],
);
