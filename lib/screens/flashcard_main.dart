// lib/screens/flashcard_main.dart
import 'package:flutter/material.dart';
import './../data/index.dart'; // instead of importing lesson20 directly
import 'flashcard_main_lesson.dart';

class FlashcardMain extends StatelessWidget {
  const FlashcardMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Lessons")),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return ListTile(
            title: Text("Lesson ${lesson.lessonNumber}: ${lesson.lessonTitle}"),
            subtitle: Text(lesson.lessonPages),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FlashcardMainLesson(lesson: lesson),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
