import 'package:hive/hive.dart';
import 'flashcard.dart';

part 'unit.g.dart';

@HiveType(typeId: 2)
class Unit extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String slug;

  @HiveField(2)
  List<Flashcard> items;

  Unit({required this.title, required this.slug, required this.items});
}
