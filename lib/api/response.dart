import 'package:dio/dio.dart';
import 'package:quiz_app/data/quiz_response.dart';

class QuizApi {
  final Dio dio = Dio();
  final String url =
      'https://opentdb.com/api.php?amount=10&category=17&difficulty=medium&type=multiple';

  Future<QuizResponse> fetchApi() async {
    try {
      final respone = await dio.get(url);
      if (respone.statusCode == 200) {
        return QuizResponse.fromJson(respone.data);
      } else {
        throw Exception('failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
