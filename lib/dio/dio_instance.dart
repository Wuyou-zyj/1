
import 'package:culture_popularization_app/dio/dio_interceptor.dart';
import 'package:culture_popularization_app/dio/dio_method.dart';
import 'package:dio/dio.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTime = const Duration(seconds: 30);

  void initDio(
      {required String baseUrl,
      String? dioMethod = DioMethod.GET,
      Duration? connectTimeout,
      Duration? receiveTimeout,
      Duration? sendTimeout}) {
    _dio.options = BaseOptions(
        method: dioMethod,
        baseUrl: baseUrl,
        contentType: 'application/json',
        connectTimeout: connectTimeout ?? _defaultTime,
        receiveTimeout: receiveTimeout ?? _defaultTime,
        sendTimeout: sendTimeout ?? _defaultTime);

     _dio.interceptors.add(DioInterceptor());
     // _dio.interceptors.add(PrintLogInterceptor());
  }

  ///GET请求
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    return await _dio.get(path,
        queryParameters: queryParameters,
        options: options ??
            Options(
                method: DioMethod.GET,
                receiveTimeout: _defaultTime,
                sendTimeout: _defaultTime));
  }

  ///POST请求
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(path,
        queryParameters: queryParameters,
        data: data,
        options: options ??
            Options(
                method: DioMethod.POST,
                receiveTimeout: _defaultTime,
                sendTimeout: _defaultTime));
  }
}
