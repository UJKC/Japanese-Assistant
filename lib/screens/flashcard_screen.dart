// lib/screens/flashcard_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/flashcard.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late Box<Flashcard> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Flashcard>('flashcards');

    if (box.isEmpty) {
      box.add(
        Flashcard(
          japanese: "こんにちは",
          meaning: "Hello",
          pronunciation: "Konnichiwa",
        ),
      );
      box.add(
        Flashcard(
          japanese: "ありがとう",
          meaning: "Thank you",
          pronunciation: "Arigatou",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final flashcards = box.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards")),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          final card = flashcards[index];
          return ListTile(
            title: Text(card.japanese),
            subtitle: Text("${card.meaning} (${card.pronunciation})"),
          );
        },
      ),
    );
  }
}
