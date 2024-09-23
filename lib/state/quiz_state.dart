// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quiz_app/api/response.dart';
// import 'package:quiz_app/%20data_model/quiz_response.dart';

// final quizApiProvider = Provider((ref) => QuizApi());
// final quizProvider = FutureProvider<QuizResponse>((ref) async {
//   return ref.read(quizApiProvider).fetchApi();
// });

// final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

// final selectedAnswerProvider = StateProvider<String?>((ref) => null);
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(QuizState());

  void checkAnswer(String selectedAnswer, String correctAnswer) {
    bool isCorrect = selectedAnswer == correctAnswer;
    state = state.copyWith(
      isAnswered: true,
      isCorrect: isCorrect,
      correctAnswers:
          isCorrect ? state.correctAnswers + 1 : state.correctAnswers,
    );
  }

  void nextQuestion(int totalQuestions) {
    if (state.currentQuestionIndex < totalQuestions - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        isAnswered: false,
      );
    }
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});
