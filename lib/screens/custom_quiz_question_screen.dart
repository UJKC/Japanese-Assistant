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

    print('\n==============================');
    print('🧠 Original meaning: "${current.meaning}"');
    print('✏️ User answer (raw): "$userAnswer"');

    // Clean and normalize a text string
    String cleanText(String text) {
      String cleaned = text
          .replaceAll(RegExp(r'\([^)]*\)'), '') // Remove (...) and content
          .replaceAll(RegExp(r'\.{3,}\??'), '') // Remove "..." or "...?"
          .replaceAll(RegExp(r'\s+'), ' ') // Normalize spaces
          .trim()
          .toLowerCase();

      return cleaned;
    }

    // Clean the meaning
    final cleanedMeaning = cleanText(current.meaning);
    print('✅ Cleaned meaning: "$cleanedMeaning"');

    // Split by semicolon into possible correct answers
    final possibleAnswers = cleanedMeaning
        .split(RegExp(r'[;,]+')) // split by ; or , just in case
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    print('🔍 Possible answers list: $possibleAnswers');

    // Clean the user's answer
    final cleanedUserAnswer = cleanText(userAnswer);
    print('🧹 Cleaned user answer: "$cleanedUserAnswer"');

    // Check if user’s answer matches any of the possible correct answers
    final isCorrect = possibleAnswers.any((ans) => ans == cleanedUserAnswer);
    print('✅ Match found? $isCorrect');

    if (isCorrect) {
      score++;
      print('🎯 Correct! Current score: $score');
    } else {
      print('❌ Incorrect. Correct answers were: $possibleAnswers');
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

      print('📦 Result saved: ${result.score}% (${result.includedLessons})');

      // ✅ Schedule navigation to avoid "setState after dispose" issues
      Future.microtask(() {
        Navigator.pushReplacement(
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
