import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../models/flashcard.dart';

class FlashcardItem extends StatelessWidget {
  final Flashcard card;

  const FlashcardItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: Card(
          elevation: 4,
          child: Container(
            height: 150,
            alignment: Alignment.center,
            child: Text(card.japanese, style: const TextStyle(fontSize: 32)),
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
                Text(card.meaning, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  card.pronunciation,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
