// lib/models/flashcard.dart
import 'package:hive/hive.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 0)
class Flashcard extends HiveObject {
  @HiveField(0)
  String japanese;

  @HiveField(1)
  String meaning;

  @HiveField(2)
  String pronunciation;

  @HiveField(3)
  bool isLearned;

  Flashcard({
    required this.japanese,
    required this.meaning,
    required this.pronunciation,
    this.isLearned = false,
  });
}
