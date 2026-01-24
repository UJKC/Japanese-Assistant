import 'package:hive/hive.dart';
import 'package:japanese_assistant/models/paragraph_unit.dart';
import 'unit.dart';

part 'paragraph_lesson.g.dart';

@HiveType(typeId: 4)
class ParagraphLesson extends HiveObject {
  @HiveField(0)
  int lessonNumber;

  @HiveField(1)
  String lessonTitle;

  @HiveField(2)
  String lessonPages;

  @HiveField(3)
  String slug;

  @HiveField(4)
  List<ParagraphUnit> units;

  ParagraphLesson({
    required this.lessonNumber,
    required this.lessonTitle,
    required this.lessonPages,
    required this.slug,
    required this.units,
  });
}
