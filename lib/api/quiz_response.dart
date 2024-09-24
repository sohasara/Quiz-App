import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ data_model/question_model.dart';

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
