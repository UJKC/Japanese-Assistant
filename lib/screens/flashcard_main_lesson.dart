// lib/screens/flashcard_main_lesson.dart
import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../models/unit.dart';
import 'flashcard_main_lesson_screen.dart';

class FlashcardMainLesson extends StatefulWidget {
  final Lesson lesson;

  const FlashcardMainLesson({super.key, required this.lesson});

  @override
  State<FlashcardMainLesson> createState() => _FlashcardMainLessonState();
}

class _FlashcardMainLessonState extends State<FlashcardMainLesson> {
  void _addUnit() {
    final titleController = TextEditingController();
    final slugController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Unit"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Unit Title"),
            ),
            TextField(
              controller: slugController,
              decoration: const InputDecoration(labelText: "Unit Slug"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newUnit = Unit(
                title: titleController.text,
                slug: slugController.text,
                items: [],
              );
              setState(() => widget.lesson.units.add(newUnit));
              Navigator.pop(ctx);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final units = widget.lesson.units;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lesson ${widget.lesson.lessonNumber}: ${widget.lesson.lessonTitle}",
        ),
      ),
      body: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          final unit = units[index];
          return ListTile(
            title: Text(unit.title),
            subtitle: Text("Unit: ${unit.slug}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FlashcardMainLessonScreen(unit: unit),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUnit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
