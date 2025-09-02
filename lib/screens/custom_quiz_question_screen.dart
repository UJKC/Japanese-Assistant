// lib/screens/custom_quiz_question_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:japanese_assistant/models/quiz_result.dart';
import '../models/flashcard.dart';
import 'quiz_result_screen.dart';
import 'dart:math';

class CustomQuizQuestionScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  final List<String> selectedLessons;

  const CustomQuizQuestionScreen({
    super.key,
    required this.flashcards,
    required this.selectedLessons,
  });

  @override
  State<CustomQuizQuestionScreen> createState() =>
      _CustomQuizQuestionScreenState();
}

class _CustomQuizQuestionScreenState extends State<CustomQuizQuestionScreen> {
  late List<Flashcard> allQuestions;
  int currentIndex = 0;
  int score = 0;

  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Shuffle flashcards
    final shuffled = List<Flashcard>.from(widget.flashcards)..shuffle(Random());

    // Apply max 20 limit
    allQuestions = shuffled.length > 20 ? shuffled.take(20).toList() : shuffled;
  }

  void checkAnswer() {
    final current = allQuestions[currentIndex];
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = current.meaning.trim().toLowerCase();

    if (userAnswer == correctAnswer) {
      score++;
    }

    _answerController.clear();

    if (currentIndex < allQuestions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // ✅ Save result before navigating
      final box = Hive.box<QuizResult>('quiz_results');
      final percentScore = ((score / allQuestions.length) * 100).round();

      final result = QuizResult(
        user: "You", // Replace with actual user if needed
        score: percentScore,
        includedLessons: widget.selectedLessons,
        date: DateTime.now(),
      );

      box.add(result);

      // ✅ Schedule navigation to avoid "setState after dispose" issues
      Future.microtask(() {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (_) =>
                QuizResultScreen(score: score, total: allQuestions.length),
          ),
        );
      });
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
              current.japanese, // question side
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: "Enter your answer",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: checkAnswer, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
