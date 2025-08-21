// lib/screens/custom_quiz_question_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import 'quiz_result_screen.dart';
import 'dart:math';

class CustomQuizQuestionScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  const CustomQuizQuestionScreen({super.key, required this.flashcards});

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
    final correctAnswer = current.pronunciation
        .trim()
        .toLowerCase(); // Assuming english is answer

    if (userAnswer == correctAnswer) {
      score++;
    }

    _answerController.clear();

    if (currentIndex < allQuestions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
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
