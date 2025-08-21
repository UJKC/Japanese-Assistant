// lib/screens/custom_quiz_question_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../models/lesson.dart';
import '../models/unit.dart';

class CustomQuizQuestionScreen extends StatefulWidget {
  final List<Lesson> lessons;

  const CustomQuizQuestionScreen({super.key, required this.lessons});

  @override
  State<CustomQuizQuestionScreen> createState() =>
      _CustomQuizQuestionScreenState();
}

class _CustomQuizQuestionScreenState extends State<CustomQuizQuestionScreen> {
  late List<Flashcard> allCards;
  int currentIndex = 0;
  String feedback = "";
  bool answered = false;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Flatten all flashcards from selected lessons
    allCards = widget.lessons.expand((lesson) {
      return lesson.units.expand((Unit u) => u.items);
    }).toList();

    allCards.shuffle();
  }

  void checkAnswer(String answer) {
    final correct = allCards[currentIndex].pronunciation;
    final meaning = allCards[currentIndex].meaning;
    setState(() {
      feedback = (answer.trim().toLowerCase() == correct.toLowerCase())
          ? "✅ Correct! and it also means ($meaning)"
          : "❌ Wrong! Correct is ($correct) → ($meaning)";
      answered = true;
    });
    controller.clear();
  }

  void nextQuestion() {
    setState(() {
      currentIndex = (currentIndex + 1) % allCards.length;
      feedback = "";
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allCards.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No flashcards in selected lessons")),
      );
    }

    final card = allCards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Custom Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(card.japanese, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              onSubmitted: checkAnswer,
              enabled: !answered,
              decoration: const InputDecoration(
                hintText: "Enter pronunciation",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(feedback, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            if (answered)
              ElevatedButton(
                onPressed: nextQuestion,
                child: const Text("Next Question"),
              ),
          ],
        ),
      ),
    );
  }
}
