// lib/screens/custom_quiz_select_screen.dart
import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'custom_quiz_question_screen.dart'; // will handle asking questions

class CustomQuizSelectScreen extends StatefulWidget {
  const CustomQuizSelectScreen({super.key});

  @override
  State<CustomQuizSelectScreen> createState() => _CustomQuizSelectScreenState();
}

class _CustomQuizSelectScreenState extends State<CustomQuizSelectScreen> {
  // Temporary static list — later we can load dynamically
  final List<Lesson> allLessons = List.generate(
    20,
    (i) => Lesson(
      lessonNumber: i + 1,
      lessonTitle: "Lesson ${i + 1}",
      lessonPages: "",
      slug: "lesson_${i + 1}",
      units: [],
    ),
  );

  late List<bool> selected; // which lessons are selected

  @override
  void initState() {
    super.initState();
    selected = List.filled(allLessons.length, true); // default all selected
  }

  void startQuiz() {
    final chosenLessons = <Lesson>[];
    for (int i = 0; i < allLessons.length; i++) {
      if (selected[i]) chosenLessons.add(allLessons[i]);
    }

    if (chosenLessons.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one lesson")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomQuizQuestionScreen(lessons: chosenLessons),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Lessons for Custom Quiz")),
      body: ListView.builder(
        itemCount: allLessons.length,
        itemBuilder: (context, index) {
          final lesson = allLessons[index];
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
