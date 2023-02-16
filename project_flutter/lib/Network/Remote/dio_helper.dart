import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
} //https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=e056ffa0ad954ad6bb1cb6d21f31647e
