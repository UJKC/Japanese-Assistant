// lib/screens/flashcard_main_lesson_screen.dart
import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../models/flashcard.dart';
import '../widgets/flashcard_item.dart';

class FlashcardMainLessonScreen extends StatefulWidget {
  final Unit unit;

  const FlashcardMainLessonScreen({super.key, required this.unit});

  @override
  State<FlashcardMainLessonScreen> createState() =>
      _FlashcardMainLessonScreenState();
}

class _FlashcardMainLessonScreenState extends State<FlashcardMainLessonScreen> {
  void _addFlashcard() {
    final jpController = TextEditingController();
    final meaningController = TextEditingController();
    final pronController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Flashcard"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: jpController,
              decoration: const InputDecoration(labelText: "Japanese"),
            ),
            TextField(
              controller: meaningController,
              decoration: const InputDecoration(labelText: "Meaning"),
            ),
            TextField(
              controller: pronController,
              decoration: const InputDecoration(labelText: "Pronunciation"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newCard = Flashcard(
                japanese: jpController.text,
                meaning: meaningController.text,
                pronunciation: pronController.text,
              );
              setState(() => widget.unit.items.add(newCard));
              Navigator.pop(ctx);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flashcards = widget.unit.items;

    return Scaffold(
      appBar: AppBar(title: Text(widget.unit.title)),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return FlashcardItem(card: flashcards[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: const Icon(Icons.add),
      ),
    );
  }
}
