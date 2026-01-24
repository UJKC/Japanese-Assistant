import 'package:flutter/material.dart';
import 'package:japanese_assistant/models/Paragraph/paragraph.dart';
import 'package:japanese_assistant/models/Paragraph/question_answer.dart';

class ParagraphQuestionScreen extends StatefulWidget {
  final Paragraph paragraph;

  const ParagraphQuestionScreen({
    super.key,
    required this.paragraph,
  });

  @override
  State<ParagraphQuestionScreen> createState() =>
      _ParagraphQuestionScreenState();
}

class _ParagraphQuestionScreenState extends State<ParagraphQuestionScreen> {
  void _showQuestionDialog({QuestionAnswer? existing, int? index}) {
    final questionController =
        TextEditingController(text: existing?.question ?? '');
    final answerController =
        TextEditingController(text: existing?.answer ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Add Question' : 'Edit Question'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final qa = QuestionAnswer(
                question: questionController.text,
                answer: answerController.text,
              );

              setState(() {
                if (existing == null) {
                  widget.paragraph.questions.add(qa);
                } else {
                  widget.paragraph.questions[index!] = qa;
                }
              });

              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteQuestion(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Question'),
        content: const Text('Are you sure you want to delete this question?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.paragraph.questions.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paragraph Questions'),
      ),
      body: widget.paragraph.questions.isEmpty
          ? const Center(
              child: Text(
                'No questions added yet',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.paragraph.questions.length,
              itemBuilder: (context, index) {
                final qa = widget.paragraph.questions[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      qa.question,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(qa.answer),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showQuestionDialog(
                            existing: qa,
                            index: index,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteQuestion(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuestionDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
