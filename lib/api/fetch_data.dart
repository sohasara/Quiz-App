// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:dio/dio.dart';

class SportApi {
  final String question;
  final String correct_answer;
  final List<String> incorrect_answer;
  SportApi({
    required this.question,
    required this.correct_answer,
    required this.incorrect_answer,
  });

  SportApi copyWith({
    String? question,
    String? correct_answer,
    List<String>? incorrect_answer,
  }) {
    return SportApi(
      question: question ?? this.question,
      correct_answer: correct_answer ?? this.correct_answer,
      incorrect_answer: incorrect_answer ?? this.incorrect_answer,
    );
  }

  factory SportApi.fromMap(Map<String, dynamic> map) {
    return SportApi(
        question: map['question'] as String,
        correct_answer: map['correct_answer'] as String,
        incorrect_answer: List<String>.from(
          (map['incorrect_answer'] as List<String>),
        ));
  }
}

class FetchData {
  final Dio dio = Dio();
  final String url =
      'https://opentdb.com/api.php?amount=10&category=17&difficulty=medium&type=multiple';
}
