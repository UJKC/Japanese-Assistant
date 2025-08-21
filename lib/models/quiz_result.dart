import 'package:hive/hive.dart';

part 'quiz_result.g.dart';

@HiveType(typeId: 3) // make sure this is unique
class QuizResult extends HiveObject {
  @HiveField(0)
  String user; // default "Ujwal"

  @HiveField(1)
  int score;

  @HiveField(2)
  List<String> includedLessons; // store lessonNumbers

  @HiveField(3)
  DateTime date;

  QuizResult({
    required this.user,
    required this.score,
    required this.includedLessons,
    required this.date,
  });
}
