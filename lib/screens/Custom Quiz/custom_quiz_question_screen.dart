// lib/screens/custom_quiz_question_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:japanese_assistant/models/quiz_result.dart';
import '../../models/Flashcard/flashcard.dart';
import '../Quiz/quiz_result_screen.dart';
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
  late List<String> options; // 4 options per question
  late String correctAnswer; // correct meaning
  bool answered = false; // track if user has selected

  @override
  void initState() {
    super.initState();

    // Shuffle flashcards
    final shuffled = List<Flashcard>.from(widget.flashcards)..shuffle(Random());

    // Apply max 20 limit
    allQuestions = shuffled.length > 20 ? shuffled.take(20).toList() : shuffled;
    generateOptions();
  }

  void checkAnswer(String selected) {
    final isCorrect = selected == correctAnswer;

    if (isCorrect) {
      score++;
    }

    setState(() {
      answered = true;
    });

    // Move to next question automatically (optional)
    Future.delayed(const Duration(milliseconds: 300), () {
      if (currentIndex < allQuestions.length - 1) {
        setState(() {
          currentIndex++;
          generateOptions();
        });
      } else {
        // existing Hive saving + navigation
        final box = Hive.box<QuizResult>('quiz_results');
        final percentScore = ((score / allQuestions.length) * 100).round();

        final result = QuizResult(
          user: "You",
          score: percentScore,
          includedLessons: widget.selectedLessons,
          date: DateTime.now(),
        );

        box.add(result);

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
    });
  }

  void generateOptions() {
    final current = allQuestions[currentIndex];
    correctAnswer = current.meaning.trim();

    // Get wrong answers from other questions
    final wrongAnswers =
        allQuestions
            .where((q) => q != current)
            .map((q) => q.meaning.trim())
            .toList()
          ..shuffle();

    options = [correctAnswer, ...wrongAnswers.take(3)]..shuffle();

    answered = false;
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
          children: [
            const Spacer(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textWidget = Text(
                    current.japanese,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );

                  // Measure the text height
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: current.japanese,
                      style: textWidget.style,
                    ),
                    maxLines: null,
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  // If text is taller than available space → scrollable
                  if (textPainter.size.height > constraints.maxHeight) {
                    return SingleChildScrollView(child: textWidget);
                  } else {
                    return Center(child: textWidget);
                  }
                },
              ),
            ),

            const SizedBox(height: 32),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: answered ? null : () => checkAnswer(option),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: Text(option, textAlign: TextAlign.center),
                  ),
                ),
              );
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
