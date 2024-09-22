import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/state/quiz_state.dart';

final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

final selectedAnswerProvider = StateProvider<String?>((ref) => null);

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);
    final currentQuestionIndex = ref.watch(currentQuestionIndexProvider);
    final selectedAnswer =
        ref.watch(selectedAnswerProvider); // Track selected answer

    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
      ),
      body: quiz.when(
        data: (data) {
          final question = data.results[currentQuestionIndex];
          final questionText = question.question;
          final incorrectAnswers = question.incorrectAnswer;
          final correctAnswer = question.correctAnswer;

          // Combine correct and incorrect answers into one list
          List<String> ans = [...incorrectAnswers, correctAnswer];

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple[100]!,
                          Colors.purple[200]!,
                          Colors.purple[100]!
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          height: 200,
                          width: 385,
                          decoration: BoxDecoration(
                            color: Colors.purple[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              questionText,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Display options
                        Expanded(
                          child: ListView.builder(
                            itemCount: ans.length,
                            itemBuilder: (context, index) {
                              final option = ans[index];
                              final isCorrect = option == correctAnswer;
                              final isSelected = option == selectedAnswer;

                              return GestureDetector(
                                onTap: () {
                                  ref
                                          .read(selectedAnswerProvider.notifier)
                                          .state =
                                      option; // Set the selected answer
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 15.0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? (isCorrect
                                                ? Colors.green
                                                : Colors.red)
                                            : Colors
                                                .transparent, // Green if correct, Red if wrong
                                        width: 4.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // The "Next Question" button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[300],
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      if (currentQuestionIndex < data.results.length - 1) {
                        // Reset selected answer when moving to the next question
                        ref.read(currentQuestionIndexProvider.notifier).state++;
                        ref.read(selectedAnswerProvider.notifier).state = null;
                      } else {
                        // If it's the last question, show a completion dialog or reset the quiz
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Quiz Completed'),
                            content: const Text(
                                'You have answered all the questions!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Reset the quiz or navigate to another page
                                  Navigator.of(context).pop();
                                  ref
                                      .read(
                                          currentQuestionIndexProvider.notifier)
                                      .state = 0;
                                  ref
                                      .read(selectedAnswerProvider.notifier)
                                      .state = null;
                                },
                                child: const Text('Restart'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Next Question',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
