// lib/screens/flashcard_main_lesson_screen.dart
import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../widgets/flashcard_item.dart';

class FlashcardMainLessonScreen extends StatelessWidget {
  final Unit unit;

  const FlashcardMainLessonScreen({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    final flashcards = unit.items;

    return Scaffold(
      appBar: AppBar(title: Text(unit.title)),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return FlashcardItem(card: flashcards[index]);
        },
      ),
    );
  }
}
