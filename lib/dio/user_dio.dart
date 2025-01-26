import 'package:dio/dio.dart';

import '../user/user_inf.dart';
class UserDio{
  static const String url = '';
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: url,
    )
  );

  static Future<Response> signin(String id, String pwd)async {
    Response res = await _dio.post(
      '/user/login',
      queryParameters: {
        "sid" : id,
        "password" : pwd
      }, 
    );
    return res;
  }

  static Future<Response> refTk()async{
    Response res = await _dio.get(
      '/user/refresh-token',
      options: Options(headers: {
        'Authorization' : User.token,
        'uid' : User.uid
      })
    );
    return res;
  }

}