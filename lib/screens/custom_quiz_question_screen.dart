// lib/screens/custom_quiz_question_screen.dart
import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../models/flashcard.dart';
import 'quiz_result_screen.dart';
import 'dart:math';

class CustomQuizQuestionScreen extends StatefulWidget {
  final List<Lesson> lessons;

  const CustomQuizQuestionScreen({super.key, required this.lessons});

  @override
  State<CustomQuizQuestionScreen> createState() =>
      _CustomQuizQuestionScreenState();
}

class _CustomQuizQuestionScreenState extends State<CustomQuizQuestionScreen> {
  late List<Flashcard> allQuestions;
  int currentIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();

    // Gather all flashcards from chosen lessons
    final List<Flashcard> cards = [];
    for (final lesson in widget.lessons) {
      for (final unit in lesson.units) {
        cards.addAll(unit.flashcards);
      }
    }

    // Shuffle cards
    cards.shuffle(Random());

    // ✅ Apply max 20 limit
    if (cards.length > 20) {
      allQuestions = cards.take(20).toList();
    } else {
      allQuestions = cards;
    }
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) score++;

    if (currentIndex < allQuestions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // ✅ Quiz finished → go to results
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              QuizResultScreen(score: score, total: allQuestions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Custom Quiz")),
        body: const Center(child: Text("No flashcards available")),
      );
    }

    final Flashcard current = allQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${currentIndex + 1} / ${allQuestions.length}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              current.japanese,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => answerQuestion(true),
              child: const Text("I knew this"),
            ),
            ElevatedButton(
              onPressed: () => answerQuestion(false),
              child: const Text("I didn’t know"),
            ),
          ],
        ),
      ),
    );
  }
}
