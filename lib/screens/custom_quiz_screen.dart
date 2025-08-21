// lib/screens/custom_quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:japanese_assistant/screens/quiz_result_screen.dart';
import 'custom_quiz_select_screen.dart';

class CustomQuizScreen extends StatelessWidget {
  const CustomQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Quiz")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("Start New Quiz"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CustomQuizSelectScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text("View Past Results"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QuizResultScreen(score: 0, total: 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
