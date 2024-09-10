import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quiz_app/data/quiz_model.dart';

// Constants for Hive box names
const String quizBoxName = 'quizBox';

final quizQuestionProvider =
    StateNotifierProvider<QuizQuestionNotifier, List<QuizQuestion>>((ref) {
  return QuizQuestionNotifier();
});

class QuizQuestionNotifier extends StateNotifier<List<QuizQuestion>> {
  QuizQuestionNotifier() : super([]);

  // Fetch questions from API and store them in Hive
  Future<void> fetchQuizQuestions(String categoryUrl) async {
    try {
      final response = await Dio().get(categoryUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];

        List<QuizQuestion> quizQuestions = data.map((item) {
          return QuizQuestion(
            category: item['category'],
            type: item['type'],
            question: item['question'],
            correctAnswer: item['correct_answer'],
            incorrectAnswer: List<String>.from(item['incorrect_answers']),
          );
        }).toList();

        // Store the questions in Hive
        await _storeQuestionsInHive(quizQuestions);

        // Update the state with the new questions
        state = quizQuestions;
      } else {
        throw Exception('Failed to load quiz data: ${response.statusMessage}');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // Load stored questions from Hive
  Future<void> loadQuestionsFromDatabase() async {
    try {
      var box = await Hive.openBox<QuizQuestion>(quizBoxName);
      state = box.values.toList();
    } catch (e) {
      _handleError(e);
    }
  }

  // Store quiz questions in Hive
  Future<void> _storeQuestionsInHive(List<QuizQuestion> quizQuestions) async {
    try {
      var box = await Hive.openBox<QuizQuestion>(quizBoxName);
      await box.clear(); // Clear old data
      await box.addAll(quizQuestions); // Add new data
    } catch (e) {
      _handleError(e);
    }
  }

  // Error handler method
  void _handleError(dynamic error) {
    // print('Error: $error'); // Better to log this to a file or service
    state = []; // Clear state if an error occurs
  }
}
