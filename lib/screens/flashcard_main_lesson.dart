// lib/screens/flashcard_main_lesson.dart
import 'package:flutter/material.dart';
import './../data/lesson20.dart';
import 'flashcard_main_lesson_screen.dart';

class FlashcardMainLesson extends StatelessWidget {
  const FlashcardMainLesson({super.key});

  @override
  Widget build(BuildContext context) {
    final units = lesson20.units;

    return Scaffold(
      appBar: AppBar(title: Text(lesson20.lessonTitle)),
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
    );
  }
}
