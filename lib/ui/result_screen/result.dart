import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        centerTitle: true,
        title: const Text(
          'Quiz Results',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You answered $correctAnswers out of $totalQuestions correctly!',
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Go back to category screen
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
