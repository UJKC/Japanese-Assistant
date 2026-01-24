import 'package:hive/hive.dart';
import 'package:japanese_assistant/models/paragraph.dart';
import 'flashcard.dart';

part 'unit.g.dart';

@HiveType(typeId: 1)
class Unit extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String slug;

  @HiveField(2)
  List<Flashcard> items;

  // @HiveField(3)
  // List<Paragraph> paragraphs;

  Unit({required this.title, required this.slug, required this.items});
}
