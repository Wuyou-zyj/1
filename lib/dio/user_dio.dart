import 'package:culture_popularization_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

import '../models/user_inf.dart';

class UserDio {

  static Future<Response> signin(String id, String pwd) async {
    Response res = await DioInstance.instance().post(
      path: 'user/login',
      data: {"sid": id, "password": pwd},
    );
    return res;
  }

  static Future<Response> refTk() async {
    Response res = await DioInstance.instance().get(path: '/user/refresh-token',
        options:
            Options(headers: {'Authorization': User.token, 'uid': User.uid}));
    return res;
  }
}
