import 'package:hive/hive.dart';

part 'question_answer.g.dart';

@HiveType(typeId: 4) // make sure this is unique
class QuestionAnswer extends HiveObject {
  @HiveField(0)
  String question;

  @HiveField(1)
  String answer;

  QuestionAnswer({
    required this.question,
    required this.answer,
  });
}
