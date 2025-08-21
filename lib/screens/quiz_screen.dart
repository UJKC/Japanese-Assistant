// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../models/lesson.dart';
import '../models/unit.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson; // 👈 we quiz on a Lesson (passed from navigation)

  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Flashcard> allCards;
  int currentIndex = 0;
  String feedback = "";

  @override
  void initState() {
    super.initState();
    // Flatten all units into one list of flashcards
    allCards = widget.lesson.units.expand((Unit u) => u.items).toList();
    allCards.shuffle(); // optional: shuffle quiz order
  }

  void checkAnswer(String answer) {
    final correct = allCards[currentIndex].meaning;
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
