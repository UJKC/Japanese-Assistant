// lib/screens/custom_quiz_select_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../data/index.dart';
import 'custom_quiz_question_screen.dart';

class CustomQuizSelectScreen extends StatefulWidget {
  const CustomQuizSelectScreen({super.key});

  @override
  State<CustomQuizSelectScreen> createState() => _CustomQuizSelectScreenState();
}

class _CustomQuizSelectScreenState extends State<CustomQuizSelectScreen> {
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    // default all selected
    selected = List.filled(lessons.length, true);
  }

  void startQuiz() {
    final chosenFlashcards = <Flashcard>[];

    for (int i = 0; i < lessons.length; i++) {
      if (selected[i]) {
        final lesson = lessons[i];
        for (final unit in lesson.units) {
          chosenFlashcards.addAll(unit.items);
        }
      }
    }

    if (chosenFlashcards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one lesson with flashcards"),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomQuizQuestionScreen(flashcards: chosenFlashcards),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Lessons for Custom Quiz")),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return CheckboxListTile(
            title: Text(
              "Lesson ${lesson.lessonNumber} - ${lesson.lessonTitle}",
            ),
            value: selected[index],
            onChanged: (val) {
              setState(() {
                selected[index] = val ?? false;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: startQuiz,
        label: const Text("Start Quiz"),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
