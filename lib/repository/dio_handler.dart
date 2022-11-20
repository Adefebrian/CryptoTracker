import 'package:dio/dio.dart';

class DioHandler{
  static Future<Response> get(url, {Map<String, dynamic>? queryParematers}) async {
    return Dio().get(url, queryParameters : queryParematers);
  }
}
