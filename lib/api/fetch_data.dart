import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/data/quiz_model.dart';

final quizProvider =
    StateNotifierProvider<QuizNotifier, AsyncValue<List<QuizQuestion>>>(
        (ref) => QuizNotifier());

class QuizNotifier extends StateNotifier<AsyncValue<List<QuizQuestion>>> {
  QuizNotifier()
      : super(const AsyncValue.loading()); // Initially, set loading state

  Future<void> fetchQuizData(String apiUrl) async {
    state =
        const AsyncValue.loading(); // Set loading state before fetching data
    final dio = Dio();
    try {
      final response = await dio.get(apiUrl);
      final List<dynamic> results = response.data['results'];
      final List<QuizQuestion> quizQuestions =
          results.map((json) => QuizQuestion.fromJson(json)).toList();

      // Storing in Hive
      var box = await Hive.openBox<QuizQuestion>('quizBox');
      await box.clear(); // Clear old data
      for (var question in quizQuestions) {
        await box.add(question);
      }

      state = AsyncValue.data(
          quizQuestions); // Set the data state after successful fetch
    } catch (error) {
      state = AsyncValue.error(
          error, StackTrace.current); // Set error state if something goes wrong
    }
  }

  // Fetch from Hive if already stored
  Future<void> getQuizFromHive() async {
    state = const AsyncValue
        .loading(); // Set loading state before fetching from Hive
    try {
      var box = await Hive.openBox<QuizQuestion>('quizBox');
      final List<QuizQuestion> quizQuestions = box.values.toList();
      if (quizQuestions.isNotEmpty) {
        state = AsyncValue.data(
            quizQuestions); // Set the data state after successfully fetching from Hive
      } else {
        state = AsyncValue.error('No data found in Hive',
            StackTrace.current); // Handle empty Hive box
      }
    } catch (error) {
      state = AsyncValue.error(
          error, StackTrace.current); // Set error state if Hive fails
    }
  }
}
