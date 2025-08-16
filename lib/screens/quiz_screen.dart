// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/flashcard.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Box<Flashcard> box;
  int currentIndex = 0;
  String feedback = "";

  @override
  void initState() {
    super.initState();
    box = Hive.box<Flashcard>('flashcards');
  }

  void checkAnswer(String answer) {
    final correct = box.getAt(currentIndex)!.meaning;
    setState(() {
      feedback = (answer.toLowerCase() == correct.toLowerCase())
          ? "✅ Correct!"
          : "❌ Wrong! ($correct)";
      currentIndex = (currentIndex + 1) % box.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (box.isEmpty)
      return const Scaffold(body: Center(child: Text("No cards")));
    final card = box.getAt(currentIndex)!;

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Column(
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
    );
  }
}
