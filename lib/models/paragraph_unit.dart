import 'package:hive/hive.dart';
import 'package:japanese_assistant/models/paragraph.dart';
import 'flashcard.dart';

part 'paragraph_unit.g.dart';

@HiveType(typeId: 5)
class ParagraphUnit extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String slug;

  @HiveField(2)
  List<Paragraph> paragraphs;

  ParagraphUnit({required this.title, required this.slug, required this.paragraphs});
}
