// lib/screens/quiz_question.dart
import 'package:flutter/material.dart';
import '../../models/Flashcard/flashcard.dart';
import '../../models/Flashcard/lesson.dart';
import '../../models/Flashcard/unit.dart';

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
  late List<String> options;
  late String correctAnswer;

  @override
  void initState() {
    super.initState();
    allCards = widget.lesson.units.expand((Unit u) => u.items).toList();
    allCards.shuffle();
    generateOptions();
  }

  void checkAnswer(String selected) {
    final meaning = correctAnswer;
    final isCorrect = selected == correctAnswer;

    setState(() {
      feedback = isCorrect
          ? "✅ Correct!"
          : "❌ Wrong! ($meaning)";
      answered = true;
    });
  }

  void nextQuestion() {
    setState(() {
      currentIndex = (currentIndex + 1) % allCards.length;
      feedback = "";
      answered = false;
      generateOptions();
    });
  }

  void generateOptions() {
    final currentCard = allCards[currentIndex];

    correctAnswer = currentCard.meaning.trim();

    // Get wrong answers from other cards
    final wrongAnswers =
        allCards
            .where((c) => c != currentCard)
            .map((c) => c.meaning.trim())
            .toList()
          ..shuffle();

    options = [correctAnswer, ...wrongAnswers.take(3)]..shuffle();
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
          children: [
            const Spacer(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textWidget = Text(
                    card.japanese,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );

                  // Measure the text height
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: card.japanese,
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

            const SizedBox(height: 20),
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

            const SizedBox(height: 20),
            Text(feedback, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            if (answered)
              ElevatedButton(
                onPressed: nextQuestion,
                child: const Text("Next Question"),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
