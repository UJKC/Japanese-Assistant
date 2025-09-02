import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // <-- 1. Import TTS
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
  late FlutterTts flutterTts; // <-- 2. Create TTS instance

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("ja-JP"); // Japanese language
    await flutterTts.setSpeechRate(0.5); // Normal speed
    await flutterTts.setPitch(1.0); // Normal pitch
  }

  Future<void> _speakText(String text) async {
    if (text.trim().isNotEmpty) {
      await flutterTts.stop(); // Stop anything currently playing
      await flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void _addFlashcard() {
    _showFlashcardDialog();
  }

  void _editFlashcard(int index) {
    final card = widget.unit.items[index];
    _showFlashcardDialog(existingCard: card, index: index);
  }

  void _deleteFlashcard(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.unit.items.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showFlashcardDialog({Flashcard? existingCard, int? index}) {
    final jpController = TextEditingController(
      text: existingCard?.japanese ?? "",
    );
    final meaningController = TextEditingController(
      text: existingCard?.meaning ?? "",
    );
    final pronController = TextEditingController(
      text: existingCard?.pronunciation ?? "",
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existingCard == null ? "Add Flashcard" : "Edit Flashcard"),
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

              setState(() {
                if (existingCard == null) {
                  widget.unit.items.add(newCard);
                } else {
                  widget.unit.items[index!] = newCard;
                }
              });

              Navigator.pop(ctx);
            },
            child: Text(existingCard == null ? "Add" : "Save"),
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
          final card = flashcards[index];
          return ListTile(
            title: FlashcardItem(card: card),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () => _speakText(card.japanese), // <-- Speak here
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editFlashcard(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      _deleteFlashcard(index), // <-- Delete feature
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: const Icon(Icons.add),
      ),
    );
  }
}
