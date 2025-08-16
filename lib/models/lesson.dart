import 'package:hive/hive.dart';
import 'unit.dart';

part 'lesson.g.dart';

@HiveType(typeId: 1)
class Lesson extends HiveObject {
  @HiveField(0)
  int lessonNumber;

  @HiveField(1)
  String lessonTitle;

  @HiveField(2)
  String lessonPages;

  @HiveField(3)
  String slug;

  @HiveField(4)
  List<Unit> units;

  Lesson({
    required this.lessonNumber,
    required this.lessonTitle,
    required this.lessonPages,
    required this.slug,
    required this.units,
  });
}
