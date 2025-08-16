import 'package:hive/hive.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 0)
class Flashcard extends HiveObject {
  @HiveField(0)
  String frontSide; // Japanese word

  @HiveField(1)
  String backSide; // English meaning

  @HiveField(2)
  String pronunciation; // for TTS

  @HiveField(3)
  bool isLearned;

  Flashcard({
    required this.frontSide,
    required this.backSide,
    this.pronunciation = "",
    this.isLearned = false,
    required String japanese,
    required String meaning,
  });

  // Convenience alias getters so existing UI code works:
  String get japanese => frontSide;
  String get meaning => backSide;

  // Optional convenience named ctor if you prefer japanese/meaning at callsites:
  Flashcard.jp({
    required String japanese,
    required String meaning,
    this.pronunciation = "",
    this.isLearned = false,
  }) : frontSide = japanese,
       backSide = meaning;
}
