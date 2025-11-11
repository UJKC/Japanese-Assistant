// lib/screens/quiz_question.dart
import 'package:flutter/material.dart';
import '../../models/flashcard.dart';
import '../../models/lesson.dart';
import '../../models/unit.dart';

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
    String answer = controller.text.trim().toLowerCase();
    String meaning = allCards[currentIndex].meaning;

    print('--- Original meaning: "$meaning" ---');

    // 1️⃣ Remove (...) and anything inside
    meaning = meaning.replaceAll(RegExp(r'\([^)]*\)'), '');
    print('After removing (...): "$meaning"');

    // 2️⃣ Remove ... and ...?
    meaning = meaning.replaceAll(RegExp(r'\.\.\.?'), '');
    print('After removing ... or ...?: "$meaning"');

    // 3️⃣ Trim and normalize spaces
    meaning = meaning.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    print('After trimming and normalizing: "$meaning"');

    // 4️⃣ Split meaning into possible answers (refine separator if needed)
    List<String> possibleAnswers = meaning
        .split(RegExp(r'[;,]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    print('Possible answers list: $possibleAnswers');

    // 5️⃣ Compare user answer
    bool isCorrect = possibleAnswers.contains(answer);
    print('User answer: "$answer" | Is correct: $isCorrect');

    setState(() {
      feedback = isCorrect
          ? "✅ Correct! It’s also ($meaning)"
          : "❌ Wrong! ($meaning)";
      answered = true;
    });

    controller.clear(); // Clear text after submit
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
