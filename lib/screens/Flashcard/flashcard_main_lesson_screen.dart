import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // ✅ 1. Import TTS
import '../../models/unit.dart';
import '../../models/flashcard.dart';

class FlashcardMainLessonScreen extends StatefulWidget {
  final Unit unit;
  final FlutterTts flutterTts;

  const FlashcardMainLessonScreen({
    super.key,
    required this.unit,
    required this.flutterTts,
  });

  @override
  State<FlashcardMainLessonScreen> createState() =>
      _FlashcardMainLessonScreenState();
}

class _FlashcardMainLessonScreenState
    extends State<FlashcardMainLessonScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isSpeaking = false;

  Flashcard get _currentCard => widget.unit.items[_currentIndex];

  @override
  void initState() {
    super.initState();

    widget.flutterTts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });

    widget.flutterTts.setCancelHandler(() {
      setState(() => _isSpeaking = false);
    });
  }

  Future<void> _speak() async {
    if (_isSpeaking) {
      await widget.flutterTts.stop();
      setState(() => _isSpeaking = false);
      return;
    }

    await widget.flutterTts.stop();
    setState(() => _isSpeaking = true);
    await widget.flutterTts.speak(_currentCard.japanese);
  }

  void _editFlashcard() {
    _showFlashcardDialog(
      existingCard: _currentCard,
      index: _currentIndex,
    );
  }

  void _deleteFlashcard() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.unit.items.removeAt(_currentIndex);
                if (_currentIndex > 0) _currentIndex--;
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
    final jpController =
        TextEditingController(text: existingCard?.japanese ?? "");
    final meaningController =
        TextEditingController(text: existingCard?.meaning ?? "");
    final pronController =
        TextEditingController(text: existingCard?.pronunciation ?? "");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existingCard == null ? "Add Flashcard" : "Edit Flashcard"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: jpController,
                decoration: const InputDecoration(labelText: "Text"),
              ),
              TextField(
                controller: meaningController,
                decoration: const InputDecoration(labelText: "Meaning"),
              ),
              TextField(
                controller: pronController,
                decoration:
                    const InputDecoration(labelText: "Pronunciation"),
              ),
            ],
          ),
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.unit.title)),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.unit.items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _isSpeaking = false;
                });
                widget.flutterTts.stop();
              },
              itemBuilder: (context, index) {
                final card = widget.unit.items[index];
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              card.japanese,
                              style: TextStyle(
                                fontSize: 28,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                                color: (_isSpeaking &&
                                        index == _currentIndex)
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            if (card.meaning.isNotEmpty)
                              Text(
                                card.meaning,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Controls
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(_isSpeaking ? Icons.pause : Icons.volume_up, size: 32,),
                  onPressed: _speak,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 32),
                  onPressed: _editFlashcard,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 32, color: Colors.red),
                  onPressed: _deleteFlashcard,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFlashcardDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
