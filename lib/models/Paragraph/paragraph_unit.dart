import 'package:hive/hive.dart';
import 'package:japanese_assistant/models/Paragraph/paragraph.dart';
import '../Flashcard/flashcard.dart';

part 'paragraph_unit.g.dart';

@HiveType(typeId: 5)
class ParagraphUnit extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String slug;

  @HiveField(2)
  List<Paragraph> items;

  ParagraphUnit({required this.title, required this.slug, required this.items});
}
