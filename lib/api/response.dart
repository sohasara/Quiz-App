// import 'package:dio/dio.dart';
// import 'package:quiz_app/%20data_model/quiz_response.dart';

// class QuizApi {
//   final Dio dio = Dio();
//   final String url =
//       "https://opentdb.com/api.php?amount=10&category=18&difficulty=medium";
//   Future<QuizResponse> fetchApi() async {
//     try {
//       final response = await dio.get(url);

//       if (response.statusCode == 200) {
//         final results = response.data['results'];
//         if (results != null && results is List) {
//           return QuizResponse.fromJson(response.data);
//         } else {
//           throw Exception(
//               'Invalid API response: "results" is null or not a list');
//         }
//       } else {
//         throw Exception(
//             'Failed to load data: Status code ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error occurred: $e');
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/example.dart';

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
