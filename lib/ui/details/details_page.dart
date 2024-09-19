import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/state/quiz_state.dart';
import 'package:quiz_app/ui/details/options.dart';

// State provider to track the current question index
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);
    final currentQuestionIndex = ref.watch(currentQuestionIndexProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
      ),
      body: quiz.when(data: (data) {
        final question = data.results[currentQuestionIndex];
        final questionText = question.question;
        final incorrectAnswers = question.incorrectAnswer;
        final correctAnswer = question.correctAnswer;

        List<String> ans = [...incorrectAnswers, correctAnswer];
        ans.shuffle();

        return Column(
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
                      padding: const EdgeInsets.all(15),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            child: Options(
                              op: ans[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (currentQuestionIndex < data.results.length - 1) {
                    ref.read(currentQuestionIndexProvider.notifier).state++;
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Quiz Completed'),
                        content:
                            const Text('You have answered all the questions!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ref
                                  .read(currentQuestionIndexProvider.notifier)
                                  .state = 0;
                            },
                            child: const Text('Restart'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Next Question'),
              ),
            ),
          ],
        );
      }, error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
