import 'package:flutter/material.dart';

class FutureUpdatesScreen extends StatelessWidget {
  const FutureUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Updates"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Planned Features",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "- Paragraph interface to show very long texts.\n"
              "- Additional AI features for language learning.\n"
              "- Listening paragraph feature.\n"
              "- Other UI improvements based on user feedback.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
