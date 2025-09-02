// lib/screens/flashcard_main.dart
import 'package:flutter/material.dart';
import './../data/index.dart'; // lessons list
// import 'package:flutter_tts/flutter_tts.dart';
import 'flashcard_main_lesson.dart';
import '../models/lesson.dart';

class FlashcardMain extends StatefulWidget {
  const FlashcardMain({super.key});

  @override
  State<FlashcardMain> createState() => _FlashcardMainState();
}

class _FlashcardMainState extends State<FlashcardMain> {
  /*
  late FlutterTts flutterTts;
  Map? _currentVoice;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initTts();
  }

  void initTts() {
    flutterTts.getVoices.then((data) {
      try {
        flutterTts.getLanguages.then((langs) {
          print("Languages: $langs");
        });
        List<Map> _voices = List<Map>.from(data);
        print("here");
        print(_voices);
        _voices = _voices
            .where((_voice) => _voice["name"].contains("en"))
            .toList();
        setState(() {
          _currentVoice = _voices.first;
          setVoice(_currentVoice!);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void setVoice(Map voice) {
    flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }
  */

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
              final newLesson = Lesson(
                lessonNumber: lessons.length + 1,
                lessonTitle: titleController.text,
                lessonPages: pagesController.text,
                units: [],
                slug: '',
              );
              setState(() => lessons.add(newLesson));
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

      floatingActionButton: FloatingActionButton(
        onPressed: _addLesson,
        child: const Icon(Icons.add),
      ),

      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.speaker_phone),
      ),
      */
    );
  }
}
