// lib/screens/flashcard_main_lesson.dart
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // ✅ Add this import
import 'package:japanese_assistant/models/paragraph_lesson.dart';
import 'package:japanese_assistant/models/paragraph_unit.dart';
import 'package:japanese_assistant/screens/Paragraph/paragraph_main_lesson_screen.dart';


class ParagraphMainLesson extends StatefulWidget {
  final ParagraphLesson lesson;
  final FlutterTts flutterTts; // ✅ Receive TTS instance

  const ParagraphMainLesson({
    super.key,
    required this.lesson,
    required this.flutterTts,
  });

  @override
  State<ParagraphMainLesson> createState() => _ParagraphMainLessonState();
}

class _ParagraphMainLessonState extends State<ParagraphMainLesson> {
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
              final newUnit = ParagraphUnit(
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
                  builder: (_) => ParagraphMainLessonScreen(
                    unit: unit,
                    flutterTts: widget.flutterTts, // ✅ Pass it forward
                  ),
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
