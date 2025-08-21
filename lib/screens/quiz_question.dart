// lib/screens/quiz_question.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../models/lesson.dart';
import '../models/unit.dart';

class QuizQuestionScreen extends StatefulWidget {
  final Lesson lesson;

  const QuizQuestionScreen({super.key, required this.lesson});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  late List<Flashcard> allCards;
  int currentIndex = 0;
  String feedback = "";

  @override
  void initState() {
    super.initState();
    allCards = widget.lesson.units.expand((Unit u) => u.items).toList();
    allCards.shuffle();
  }

  void checkAnswer(String answer) {
    final correct = allCards[currentIndex].pronunciation;
    setState(() {
      feedback = (answer.trim().toLowerCase() == correct.toLowerCase())
          ? "✅ Correct!"
          : "❌ Wrong! ($correct)";
      currentIndex = (currentIndex + 1) % allCards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allCards.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No flashcards available")),
      );
    }

    final card = allCards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz - Lesson ${widget.lesson.lessonNumber}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(card.japanese, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            TextField(
              onSubmitted: checkAnswer,
              decoration: const InputDecoration(
                hintText: "Enter meaning",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(feedback, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
