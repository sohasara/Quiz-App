import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizData {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuizData({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizData.fromMap(Map<String, dynamic> map) {
    return QuizData(
      question: map['question'] as String,
      correctAnswer: map['correct_answer'] as String,
      incorrectAnswers: List<String>.from(map['incorrect_answers'] as List),
    );
  }
}

class QuizResponse {
  final List<QuizData> results;

  QuizResponse({
    required this.results,
  });

  factory QuizResponse.fromMap(Map<String, dynamic> map) {
    return QuizResponse(
      results: List<QuizData>.from(
        (map['results'] as List<dynamic>).map(
          (item) => QuizData.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class QuizApi {
  final Dio _dio = Dio();
  final String _url =
      'https://opentdb.com/api.php?amount=10&category=17&difficulty=medium&type=multiple';

  Future<QuizResponse> fetchQuiz() async {
    try {
      final response = await _dio.get(_url);
      if (response.statusCode == 200) {
        return QuizResponse.fromMap(response.data);
      } else {
        throw Exception('Failed to load quiz');
      }
    } catch (e) {
      throw Exception('Error fetching quiz: $e');
    }
  }
}

final quizApiProvider = Provider((ref) => QuizApi());

final quizProvider = FutureProvider<QuizResponse>((ref) async {
  final quizApi = ref.read(quizApiProvider);
  return await quizApi.fetchQuiz();
});

class QuizState {
  final int currentQuestionIndex;
  final String? selectedAnswer;
  final List<bool> answerResults;

  QuizState({
    required this.currentQuestionIndex,
    this.selectedAnswer,
    this.answerResults = const [],
  });

  QuizState copyWith({
    int? currentQuestionIndex,
    String? selectedAnswer,
    List<bool>? answerResults,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      answerResults: answerResults ?? this.answerResults,
    );
  }
}

class QuizStateNotifier extends StateNotifier<QuizState> {
  QuizStateNotifier() : super(QuizState(currentQuestionIndex: 0));

  void selectAnswer(String answer) {
    state = state.copyWith(selectedAnswer: answer);
  }

  void nextQuestion(int totalQuestions, String correctAnswer) {
    bool isCorrect = state.selectedAnswer == correctAnswer;

    if (state.currentQuestionIndex < totalQuestions - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedAnswer: null,
        answerResults: [...state.answerResults, isCorrect],
      );
    } else {
      state = state.copyWith(
        answerResults: [...state.answerResults, isCorrect],
      );
    }
  }

  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
        selectedAnswer: null,
      );
    }
  }

  int get correctAnswersCount =>
      state.answerResults.where((result) => result).length;
  int get incorrectAnswersCount =>
      state.answerResults.where((result) => !result).length;
}

final quizStateNotifierProvider =
    StateNotifierProvider<QuizStateNotifier, QuizState>((ref) {
  return QuizStateNotifier();
});

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizAsyncValue = ref.watch(quizProvider);
    final quizState = ref.watch(quizStateNotifierProvider);
    final quizNotifier = ref.read(quizStateNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: quizAsyncValue.when(
        data: (quizResponse) {
          final quizList = quizResponse.results;

          // If the quiz is completed, show the result screen
          if (quizState.currentQuestionIndex >= quizList.length) {
            final correctAnswers = quizNotifier.correctAnswersCount;
            final incorrectAnswers = quizNotifier.incorrectAnswersCount;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quiz Completed!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text('Correct Answers: $correctAnswers'),
                  Text('Incorrect Answers: $incorrectAnswers'),
                  ElevatedButton(
                    onPressed: () {
                      // Optionally reset the quiz here
                    },
                    child: const Text('Restart Quiz'),
                  ),
                ],
              ),
            );
          }

          final currentQuestion = quizList[quizState.currentQuestionIndex];
          List<String> options = [
            currentQuestion.correctAnswer,
            ...currentQuestion.incorrectAnswers
          ]..shuffle();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Question ${quizState.currentQuestionIndex + 1}: ${currentQuestion.question}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView(
                  children: options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: quizState.selectedAnswer,
                      onChanged: (value) {
                        quizNotifier.selectAnswer(value!);
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: quizState.currentQuestionIndex > 0
                          ? () => quizNotifier.previousQuestion()
                          : null,
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: quizState.selectedAnswer != null
                          ? () => quizNotifier.nextQuestion(
                                quizList.length,
                                currentQuestion.correctAnswer,
                              )
                          : null,
                      child: Text(
                          quizState.currentQuestionIndex < quizList.length - 1
                              ? 'Next'
                              : 'Finish'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
