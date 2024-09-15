import 'package:quiz_app/data/quiz_model.dart';

class QuizResponse {
  final List<QuizQuestion> results;

  QuizResponse({required this.results});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      results: List<QuizQuestion>.from(
        (json['results'] as List<dynamic>).map(
          (item) => QuizQuestion.fromJson(item as Map<String, dynamic>),
        ),
      ),
    );
  }
}
