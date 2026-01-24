import 'package:hive/hive.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 2)
class Flashcard extends HiveObject {
  @HiveField(0)
  String japanese; // Japanese word

  @HiveField(1)
  String meaning; // English meaning

  @HiveField(2)
  String pronunciation; // for TTS

  @HiveField(3)
  bool isLearned;

  Flashcard({
    required this.japanese,
    required this.meaning,
    this.pronunciation = "",
    this.isLearned = false,
  });
}
