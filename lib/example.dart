import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category {
  final String name;
  final String apiUrl;

  Category({required this.name, required this.apiUrl});
}

final List<Category> categories = [
  Category(
      name: 'Sports',
      apiUrl:
          'https://opentdb.com/api.php?amount=10&category=21&difficulty=medium'),
  Category(
      name: 'Films',
      apiUrl:
          'https://opentdb.com/api.php?amount=10&category=11&difficulty=medium'),
  // Add other categories...
  Category(
      name: 'politics',
      apiUrl:
          'https://opentdb.com/api.php?amount=10&category=24&difficulty=medium&type=multiple'),
  Category(
      name: 'computer',
      apiUrl:
          'https://opentdb.com/api.php?amount=10&category=18&difficulty=medium'),
  // Add other categories...
];

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(category: category),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  category.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Create a provider to fetch questions for the selected category
final quizQuestionsProvider =
    FutureProvider.family<List<Question>, String>((ref, apiUrl) async {
  final response = await Dio().get(apiUrl);
  final data = response.data;

  // Check for response_code and handle the results
  if (data['response_code'] == 0) {
    return (data['results'] as List).map((q) => Question.fromJson(q)).toList();
  } else {
    throw Exception('Failed to load questions');
  }
});

class QuizScreen extends ConsumerWidget {
  final Category category;
  const QuizScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestions = ref.watch(quizQuestionsProvider(category.apiUrl));

    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${category.name}')),
      body: quizQuestions.when(
        data: (questions) => QuizBody(questions: questions),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Failed to load questions: $error')),
      ),
    );
  }
}

class QuizBody extends ConsumerWidget {
  final List<Question> questions;
  const QuizBody({super.key, required this.questions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final currentQuestion = questions[quizState.currentQuestionIndex];

    return Column(
      children: [
        Text(currentQuestion.question),
        ...currentQuestion.options.map((option) {
          return GestureDetector(
            onTap: () {
              if (!quizState.isAnswered) {
                quizNotifier.checkAnswer(option, currentQuestion.correctAnswer);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                        correctAnswers: quizState.correctAnswers,
                        totalQuestions: questions.length),
                  ),
                );
              }
            },
            child: const Text('Next Question'),
          ),
      ],
    );
  }
}

// Quiz state class to hold all necessary state variables
class QuizState {
  final int currentQuestionIndex;
  final int correctAnswers;
  final bool isAnswered;
  final bool isCorrect;

  QuizState({
    this.currentQuestionIndex = 0,
    this.correctAnswers = 0,
    this.isAnswered = false,
    this.isCorrect = false,
  });

  QuizState copyWith({
    int? currentQuestionIndex,
    int? correctAnswers,
    bool? isAnswered,
    bool? isCorrect,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}

// Define a QuizNotifier to manage the quiz state
class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(QuizState());

  // Method to check the answer and update state
  void checkAnswer(String selectedAnswer, String correctAnswer) {
    bool isCorrect = selectedAnswer == correctAnswer;
    state = state.copyWith(
      isAnswered: true,
      isCorrect: isCorrect,
      correctAnswers:
          isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
    );
  }

  // Method to move to the next question
  void nextQuestion(int totalQuestions) {
    if (state.currentQuestionIndex < totalQuestions - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        isAnswered: false,
      );
    }
  }
}

// Create a provider for the QuizNotifier
final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultScreen(
      {super.key, required this.correctAnswers, required this.totalQuestions});

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

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> options = List<String>.from(json['incorrect_answers']);
    options.add(json['correct_answer']);
    options.shuffle(); // Shuffle so the correct answer isn't always last

    return Question(
      question: json['question'],
      options: options,
      correctAnswer: json['correct_answer'],
    );
  }
}
