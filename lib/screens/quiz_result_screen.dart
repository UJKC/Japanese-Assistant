// lib/screens/quiz_result_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/quiz_result.dart';

class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final Box<QuizResult> _resultBox = Hive.box<QuizResult>('quiz_results');
  int currentPage = 0;
  final int resultsPerPage = 10;

  List<QuizResult> get _paginatedResults {
    final all = _resultBox.values.toList().reversed.toList(); // latest first
    final start = currentPage * resultsPerPage;
    final end = (start + resultsPerPage < all.length)
        ? start + resultsPerPage
        : all.length;
    return all.sublist(start, end);
  }

  void _nextPage() {
    if ((currentPage + 1) * resultsPerPage < _resultBox.length) {
      setState(() => currentPage++);
    }
  }

  void _prevPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  String _formatLessons(List<int> lessons) {
    if (lessons.length <= 5) {
      return lessons.join(", ");
    } else {
      final firstFive = lessons.take(5).join(", ");
      return "$firstFive ...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Results")),
      body: ValueListenableBuilder(
        valueListenable: _resultBox.listenable(),
        builder: (context, Box<QuizResult> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No quiz results yet."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _paginatedResults.length,
                  itemBuilder: (context, index) {
                    final result = _paginatedResults[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: ListTile(
                        title: Text(
                          "${result.user} — Score: ${result.score}%",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Lessons: ${_formatLessons(result.lessonsIncluded)}\nDate: ${result.timestamp.toLocal()}",
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _prevPage,
                    child: const Text("Previous"),
                  ),
                  Text("Page ${currentPage + 1}"),
                  TextButton(onPressed: _nextPage, child: const Text("Next")),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
