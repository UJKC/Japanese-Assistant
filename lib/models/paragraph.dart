import 'package:hive/hive.dart';
import 'question_answer.dart';

part 'paragraph.g.dart';

@HiveType(typeId: 6)
class Paragraph extends HiveObject {
  @HiveField(0)
  String title; // optional but useful

  @HiveField(1)
  String content; // the big paragraph text

  @HiveField(2)
  String meaning;

  @HiveField(3)
  List<QuestionAnswer> questions;

  Paragraph({
    required this.title,
    required this.content,
    required this.meaning,
    required this.questions,
  });
}
