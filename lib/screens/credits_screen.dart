import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credits"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "About Me - Ujwal K C",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "I’m a dynamic individual whose life extends far beyond the desk.\n\n"
              "Currently working at LTIMindtree, I’ve been affectionately nicknamed \"Night Manager\" and \"Crisis Mitigator\" for my ability to turn challenges into successes.\n\n"
              "I thrive at:\n"
              "- Building innovative software across domains — from automation to finance to full-stack web apps.\n"
              "- Finding hidden opportunities and implementing cost-saving strategies.\n"
              "- Bridging gaps between tech and business to create solutions that last.\n\n"
              "Fun facts:\n"
              "- I love traveling on foot or by public transport to soak in local cultures 🌏.\n"
              "- I binge-watch series to unwind 📺.\n"
              "- Managing my finances is my secret superpower 💰.\n"
              "- Books are my jam (well… after my friends started quizzing me about them) 📚.\n"
              "- Meeting new people fuels my energy — you won’t be bored with me around 😄.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
