import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quiz_app/%20data_model/question_model.dart';
import 'package:quiz_app/state/quiz_state.dart';

class DetailsPage extends ConsumerWidget {
  final List<Question> questions;
  const DetailsPage({super.key, required this.questions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final currentQuestion = questions[quizState.currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text(currentQuestion.question),
          ),
          ...currentQuestion.options.map((option) {
            return GestureDetector(
              onTap: () {
                if (!quizState.isAnswered) {
                  quizNotifier.checkAnswer(
                      option, currentQuestion.correctAnswer);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: quizState.isAnswered &&
                            option == currentQuestion.correctAnswer
                        ? Colors.green
                        : quizState.isAnswered &&
                                option != currentQuestion.correctAnswer
                            ? Colors.red
                            : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(option),
              ),
            );
          }),
          if (quizState.isAnswered)
            ElevatedButton(
              onPressed: () {
                quizNotifier.nextQuestion(questions.length);
                if (quizState.currentQuestionIndex >= questions.length - 1) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ResultScreen(
                  //         correctAnswers: quizState.correctAnswers,
                  //         totalQuestions: questions.length),
                  //   ),
                  // );
                }
              },
              child: const Text('Next Question'),
            ),
        ],
      ),
    );
  }
}
