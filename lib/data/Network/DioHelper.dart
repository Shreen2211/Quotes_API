import 'dart:convert';

import 'package:dio/dio.dart';
import 'endPoint.dart';

class dioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: End_Piont.baseURL,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }));
  }
  static Future<Response> get(
      {required String endpoint, String? token,Map<String,dynamic>? params}) async {
    try {
      dio?.options.headers = {
        "Authorization": "Token token=\"$token\"",
      };
      Response? res = await dio?.get(endpoint, queryParameters: params);
      return res!;
    } catch (e) {
      rethrow;
    }
  }
    static Future<Response> put(
        {required String endpoint, String? token,Map<String,dynamic>? body}) async {
      try {
        dio?.options.headers = {
          "Authorization": "Token token=\"$token\"",
        };
        Response? res = await dio?.put(endpoint,data: body);
        return res!;
      } catch (e) {
        rethrow;
      }
  }
}
