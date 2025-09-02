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
  bool answered = false; // track if user has answered
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    allCards = widget.lesson.units.expand((Unit u) => u.items).toList();
    allCards.shuffle();
  }

  void checkAnswer() {
    final answer = controller.text;
    // final correct = allCards[currentIndex].pronunciation;
    final meaning = allCards[currentIndex].meaning;

    setState(() {
      feedback = (answer.trim().toLowerCase() == meaning.toLowerCase())
          ? "✅ Correct! and its also ($meaning)"
          : "❌ Wrong! ($meaning)";
      answered = true;
    });

    controller.clear(); // clear text after submit
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
              controller: controller,
              enabled: !answered, // disable typing after answer
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: "Enter meaning",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) =>
                  checkAnswer(), // optional, still works on keyboard Done
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: answered
                  ? null
                  : checkAnswer, // disable button after answering
              child: const Text("Submit"),
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
