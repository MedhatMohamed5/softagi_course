import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  DioHelper._();

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await _dio.get(url, queryParameters: query);
  }
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
