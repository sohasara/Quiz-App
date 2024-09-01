import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/data/sport_data.dart';

class Api {
  final Dio dio = Dio();
  final String url =
      'https://opentdb.com/api.php?amount=10&category=21&difficulty=medium';
  Future<SportsData> fetch() async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return SportsData.fromMap(response.data);
    } else {
      throw Exception('data not found');
    }
  }
}

final apiProvider = Provider<Api>(
  (ref) {
    return Api();
  },
);
final sportProvider = FutureProvider(
  (ref) {
    final apiservice = ref.watch(apiProvider);
    return apiservice.fetch();
  },
);
