import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flip_card/flip_card.dart';
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Card(
                elevation: 4,
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Text(
                    card.japanese,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              back: Card(
                elevation: 4,
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        card.pronunciation,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card.meaning,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
