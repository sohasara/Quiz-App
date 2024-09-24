import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultScreen({required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You answered $correctAnswers out of $totalQuestions correctly!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to category screen
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
