import 'package:flutter/material.dart';
import 'package:japanese_assistant/screens/Custom%20Quiz/custom_quiz_screen.dart';
import 'Flashcard/flashcard_main.dart';
import 'Quiz/quiz_screen.dart';
import 'credits_screen.dart';
import 'future_updates_screen.dart';
import 'ai_updates_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Japanese Flashcards",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // Flashcards Button
                _buildMenuButton(
                  context,
                  title: "Learn Flashcards",
                  icon: Icons.book,
                  color: Colors.orange,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FlashcardMain()),
                  ),
                ),
                const SizedBox(height: 20),

                // Quiz Button
                _buildMenuButton(
                  context,
                  title: "Take Quiz",
                  icon: Icons.quiz,
                  color: Colors.blue,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // Custom Quiz Button
                _buildMenuButton(
                  context,
                  title: "Custom Quiz",
                  icon: Icons.edit,
                  color: Colors.green,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CustomQuizScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // Credits Button
                _buildMenuButton(
                  context,
                  title: "Credits",
                  icon: Icons.person,
                  color: Colors.teal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreditsScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // Future Updates Button
                _buildMenuButton(
                  context,
                  title: "Future Updates",
                  icon: Icons.update,
                  color: Colors.indigo,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FutureUpdatesScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // AI Updates Button
                _buildMenuButton(
                  context,
                  title: "AI Updates",
                  icon: Icons.smart_toy,
                  color: Colors.pink,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AIUpdatesScreen()),
                  ),
                ),
                const SizedBox(height: 20),

                // Report Issue Button (opens GitHub in-app)
                _buildMenuButton(
                  context,
                  title: "Report Issue",
                  icon: Icons.bug_report,
                  color: Colors.redAccent,
                  onTap: () async {
                    final Uri url = Uri.parse(
                        "https://github.com/UJKC/Japanese-Assistant/issues");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                        webViewConfiguration:
                            const WebViewConfiguration(enableJavaScript: true),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Could not open GitHub link")),
                      );
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 240,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
