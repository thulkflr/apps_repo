import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url,
      required Map<String, dynamic> query,
      String lang = 'en',
      required String token}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String lang = 'en',
      required String token}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return await dio.post(
      url,
      data: data,
    );
  }
} //https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=e056ffa0ad954ad6bb1cb6d21f31647e
