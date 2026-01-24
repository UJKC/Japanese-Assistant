import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // ✅ 1. Import TTS
import 'package:japanese_assistant/models/Paragraph/paragraph.dart';
import 'package:japanese_assistant/models/Paragraph/paragraph_unit.dart';
import 'package:japanese_assistant/screens/Paragraph/paragraph_main_lesson_question-screen.dart';

class ParagraphMainLessonScreen extends StatefulWidget {
  final ParagraphUnit unit;
  final FlutterTts flutterTts;

  const ParagraphMainLessonScreen({
    super.key,
    required this.unit,
    required this.flutterTts,
  });

  @override
  State<ParagraphMainLessonScreen> createState() =>
      _ParagraphMainLessonScreenState();
}

class _ParagraphMainLessonScreenState extends State<ParagraphMainLessonScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isSpeaking = false;
  bool _isFlipped = false;

  Paragraph get _currentCard => widget.unit.items[_currentIndex];

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
    await widget.flutterTts.speak(_currentCard.content);
  }

  void _editFlashcard() {
    _showFlashcardDialog(existingCard: _currentCard, index: _currentIndex);
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

  void _showFlashcardDialog({Paragraph? existingCard, int? index}) {
    final jpController = TextEditingController(
      text: existingCard?.content ?? "",
    );
    final meaningController = TextEditingController(
      text: existingCard?.meaning ?? "",
    );
    final titleController = TextEditingController(
      text: existingCard?.title ?? "",
    );
    final questionController = existingCard?.questions ?? [];

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
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
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
              final newCard = Paragraph(
                title: titleController.text,
                content: jpController.text,
                meaning: meaningController.text,
                questions: questionController,
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
                  _isFlipped = false;
                });
                widget.flutterTts.stop();
              },
              itemBuilder: (context, index) {
                final card = widget.unit.items[index];
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: GestureDetector(
                    onTap: () {
                      if (index == _currentIndex) {
                        setState(() => _isFlipped = !_isFlipped);
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        final rotate = Tween(
                          begin: pi,
                          end: 0.0,
                        ).animate(animation);
                        return AnimatedBuilder(
                          animation: rotate,
                          child: child,
                          builder: (context, child) {
                            final isUnder =
                                (ValueKey(_isFlipped) != child!.key);
                            final tilt = isUnder
                                ? min(rotate.value, pi / 2)
                                : rotate.value;
                            return Transform(
                              transform: Matrix4.rotationY(tilt),
                              alignment: Alignment.center,
                              child: child,
                            );
                          },
                        );
                      },
                      child: _isFlipped
                          ? _buildBackCard(card)
                          : _buildFrontCard(card, index),
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
                  icon: Icon(
                    _isSpeaking ? Icons.pause : Icons.volume_up,
                    size: 32,
                  ),
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
                IconButton(
                  icon: const Icon(Icons.question_answer_rounded, size: 32),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ParagraphQuestionScreen(
                          paragraph: _currentCard,
                        ),
                      ),
                    );
                  },
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

  Widget _buildFrontCard(Paragraph card, int index) {
    return Card(
      key: const ValueKey(false),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textWidget = Text(
              card.content,
              style: TextStyle(
                fontSize: 28,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: (_isSpeaking && index == _currentIndex)
                    ? Colors.blue
                    : Colors.black,
              ),
              textAlign: TextAlign.center,
            );

            // Measure if the text exceeds the available height
            final textPainter =
                TextPainter(
                  text: TextSpan(text: card.content, style: textWidget.style),
                  maxLines: null,
                  textDirection: TextDirection.ltr,
                )..layout(
                  maxWidth: constraints.maxWidth - 40,
                ); // padding adjustment

            if (textPainter.size.height > constraints.maxHeight) {
              return SingleChildScrollView(child: textWidget);
            } else {
              return Center(child: textWidget);
            }
          },
        ),
      ),
    );
  }

  Widget _buildBackCard(Paragraph card) {
    return Card(
      key: const ValueKey(true),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textWidget = Text(
              card.meaning,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            );

            final textPainter =
                TextPainter(
                  text: TextSpan(text: card.meaning, style: textWidget.style),
                  maxLines: null,
                  textDirection: TextDirection.ltr,
                )..layout(
                  maxWidth: constraints.maxWidth - 40,
                ); // padding adjustment

            if (textPainter.size.height > constraints.maxHeight) {
              return SingleChildScrollView(child: textWidget);
            } else {
              return Center(child: textWidget);
            }
          },
        ),
      ),
    );
  }
}
