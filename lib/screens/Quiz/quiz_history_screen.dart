// lib/screens/quiz_history_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/quiz_result.dart';

class QuizHistoryScreen extends StatelessWidget {
  const QuizHistoryScreen({super.key});

  String _formatLessons(List<String> lessons) {
    return lessons.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    final Box<QuizResult> resultBox = Hive.box<QuizResult>('quiz_results');

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz History")),
      body: ValueListenableBuilder(
        valueListenable: resultBox.listenable(),
        builder: (context, Box<QuizResult> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No history available."));
          }

          final results = box.values.toList().reversed.toList(); // latest first

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(
                    "${result.user} — ${result.score}%",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Lessons: ${_formatLessons(result.includedLessons)}\n"
                    "Date: ${result.date.toLocal()}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
