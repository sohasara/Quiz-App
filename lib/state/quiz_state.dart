import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/api/response.dart';
import 'package:quiz_app/%20data_model/quiz_response.dart';

final quizApiProvider = Provider((ref) => QuizApi());
final quizProvider = FutureProvider<QuizResponse>((ref) async {
  return ref.read(quizApiProvider).fetchApi();
});

final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

final selectedAnswerProvider = StateProvider<String?>((ref) => null);
