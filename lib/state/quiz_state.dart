import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/api/response.dart';
import 'package:quiz_app/data/quiz_response.dart';

final quizApiProvider = Provider((ref) => QuizApi());

final quizProvider = FutureProvider<QuizResponse>((ref) async {
  try {
    return await QuizApi().fetchApi();
  } catch (e) {
    throw Exception("Failed to load quiz: $e");
  }
});
