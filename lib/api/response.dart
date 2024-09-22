import 'package:dio/dio.dart';
import 'package:quiz_app/%20data_model/quiz_response.dart';

class QuizApi {
  final Dio dio = Dio();
  final String url =
      "https://opentdb.com/api.php?amount=10&category=18&difficulty=medium";
  Future<QuizResponse> fetchApi() async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results != null && results is List) {
          return QuizResponse.fromJson(response.data);
        } else {
          throw Exception(
              'Invalid API response: "results" is null or not a list');
        }
      } else {
        throw Exception(
            'Failed to load data: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
