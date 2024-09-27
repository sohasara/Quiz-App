import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quiz_app/%20data_model/question_model.dart';
import 'package:quiz_app/state/quiz_state.dart';
import 'package:quiz_app/ui/result_screen/result.dart';

class DetailsPage extends ConsumerWidget {
  final List<Question> questions;
  const DetailsPage({super.key, required this.questions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final currentQuestion = questions[quizState.currentQuestionIndex];
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Container(
                height: 170,
                width: 380,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  currentQuestion.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ...currentQuestion.options.map((option) {
              return GestureDetector(
                onTap: () {
                  if (!quizState.isAnswered) {
                    quizNotifier.checkAnswer(
                        option, currentQuestion.correctAnswer);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 60,
                    width: 380,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple[300],
                      border: Border.all(
                        width: 2,
                        color: quizState.isAnswered &&
                                option == currentQuestion.correctAnswer
                            ? Colors.green
                            : quizState.isAnswered &&
                                    option != currentQuestion.correctAnswer
                                ? Colors.red
                                : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 30,
            ),
            if (quizState.isAnswered)
              GestureDetector(
                onTap: () {
                  quizNotifier.nextQuestion(questions.length);
                  if (quizState.currentQuestionIndex >= questions.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          correctAnswers: quizState.correctAnswers,
                          totalQuestions: questions.length,
                          questions: questions,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Next Question',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
