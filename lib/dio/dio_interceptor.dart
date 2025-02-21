import 'package:culture_popularization_app/models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DioInterceptor extends InterceptorsWrapper {
  

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.contains('user/login')) {
      handler.next(response);
      return;
    }
    if (response.statusCode == 200) {
      try {
        var res = BaseModel.fromJson(response.data);
        if (res.code == 200) {
          if (res.data == null) {
            handler.next(
                Response(requestOptions: response.requestOptions, data: true));
          } else {
            handler.next(Response(
                requestOptions: response.requestOptions, data: res.data));
          }
        } else {

        }
      } catch (e) {
        handler.reject(
            DioException(requestOptions: response.requestOptions, error: "$e"));
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final SharedPreferences sp=await SharedPreferences.getInstance();
    if(options.path.contains('user/login')){
      handler.next(options);
    }else{
      options.headers['Authorization'] = sp.getString('token_f');
      options.headers['uid'] = sp.getInt('uid_f');
      handler.next(options);

    }
  }

}
