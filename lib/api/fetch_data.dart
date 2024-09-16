import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizResponse {
  final int responseCode;
  final List<Question> results;

  QuizResponse({required this.responseCode, required this.results});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      responseCode: json['response_code'],
      results: List<Question>.from(json['results']
          .map((questionJson) => Question.fromJson(questionJson))),
    );
  }
}

class Question {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }
}

class QuizApi {
  final Dio _dio = Dio();
  final String _url =
      'https://opentdb.com/api.php?amount=10&category=24&difficulty=medium&type=multiple';

  Future<QuizResponse> fetchQuiz() async {
    final response = await _dio.get(_url);

    if (response.statusCode == 200) {
      return QuizResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load quiz');
    }
  }
}

final quizProvider = FutureProvider<QuizResponse>((ref) async {
  return QuizApi().fetchQuiz();
});

class QuizPage extends ConsumerWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizAsyncValue = ref.watch(quizProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: quizAsyncValue.when(
        data: (quizResponse) {
          return ListView.builder(
            itemCount: quizResponse.results.length,
            itemBuilder: (context, index) {
              final question = quizResponse.results[index];
              final answers = [
                ...question.incorrectAnswers,
                question.correctAnswer
              ]..shuffle(); // Shuffle answers

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q: ${question.question}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...answers.map(
                        (answer) => ListTile(
                          title: Text(answer),
                          onTap: () {
                            final isCorrect = answer == question.correctAnswer;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isCorrect
                                    ? 'Correct!'
                                    : 'Wrong, the correct answer is ${question.correctAnswer}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
