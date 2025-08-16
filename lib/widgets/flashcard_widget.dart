import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardWidget({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Card(
        child: Center(
          child: Text(
            flashcard.frontSide,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
      back: Card(
        child: Center(
          child: Text(
            "${flashcard.backSide}\n(${flashcard.pronunciation})",
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
