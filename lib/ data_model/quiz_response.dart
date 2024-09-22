import 'package:quiz_app/%20data_model/quiz_model.dart';

class QuizResponse {
  final List<QuizQuestion> results;

  QuizResponse({required this.results});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      results: List<QuizQuestion>.from(
        (json['results'] as List<dynamic>).map(
          (item) => QuizQuestion.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }
}