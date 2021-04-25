import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:udemy_flutter/shop_app/shared/network/endpoints.dart';

class ShopDioHelper {
  static Dio _dio;

  ShopDioHelper._();

  static void init() {
    _dio = Dio(
      BaseOptions(
          baseUrl: BASE_URL,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang': 'en',
          }),
    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String, dynamic> query,
    String lang = 'ar',
    String authorizationToken = '',
  }) async {
    _dio.options.headers.addAll(
      {
        'lang': lang,
        'Authorization': authorizationToken,
      },
    );
    return await _dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'ar',
    String authorizationToken = '',
  }) async {
    _dio.options.headers.addAll(
      {
        'lang': lang,
        'Authorization': authorizationToken,
      },
    );
    return await _dio.post(url, data: data, queryParameters: query);
  }
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
