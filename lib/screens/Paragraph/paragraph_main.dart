// lib/screens/flashcard_main.dart
import 'package:flutter/material.dart';
import 'package:japanese_assistant/models/Paragraph/paragraph_lesson.dart';
import 'package:japanese_assistant/screens/Paragraph/paragraph_main_lesson.dart';
import '../../data/index.dart'; // lessons list
import '../../main.dart'; // ✅ import to access global flutterTts

class ParagraphMain extends StatefulWidget {
  const ParagraphMain({super.key});

  @override
  State<ParagraphMain> createState() => _ParagraphMainState();
}

class _ParagraphMainState extends State<ParagraphMain> {
  void _addLesson() {
    final titleController = TextEditingController();
    final pagesController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Lesson"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Lesson Title"),
            ),
            TextField(
              controller: pagesController,
              decoration: const InputDecoration(labelText: "Lesson Pages"),
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
              final newLesson = ParagraphLesson(
                lessonNumber: lessons.length,
                lessonTitle: titleController.text,
                lessonPages: pagesController.text,
                units: [],
                slug: '',
              );
              setState(() => paragraphLessons.add(newLesson));
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
    return Scaffold(
      appBar: AppBar(title: const Text("All Lessons")),
      body: ListView.builder(
        itemCount: paragraphLessons.length,
        itemBuilder: (context, index) {
          final lesson = paragraphLessons[index];
          return ListTile(
            title: Text("Lesson ${lesson.lessonNumber}: ${lesson.lessonTitle}"),
            subtitle: Text(lesson.lessonPages),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ParagraphMainLesson(
                    lesson: lesson,
                    flutterTts: flutterTts, // ✅ Pass global TTS
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLesson,
        child: const Icon(Icons.add),
      ),
    );
  }
}
