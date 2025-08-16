// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Japanese Flashcards")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Learn Flashcards"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FlashcardScreen()),
              ),
            ),
            ElevatedButton(
              child: const Text("Take Quiz"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
