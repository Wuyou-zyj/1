import 'package:culture_popularization_app/models/user_inf.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio _dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'YOUR_BASE_URL',
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Add interceptors for auth headers
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth headers from secure storage
        options.headers['Authorization'] = User.token;
        options.headers['uid'] = User.uid;
        return handler.next(options);
      },
    ));
  }

  Future<Response> getPuzzleInfo() async {
    return await _dio.get('/puzzle/get');
  }

  Future<Response> movePuzzle(int puzzleId, List<int> unfinished) async {
    return await _dio.post('/puzzle/move', data: {
      'puzzleId': puzzleId,
      'unfinished': unfinished,
    });
  }

  Future<Response> withdrawMove() async {
    return await _dio.post('/puzzle/withdraw');
  }

  Future<Response> refreshPuzzle() async {
    return await _dio.get('/puzzle/refresh');
  }

  Future<Response> savePuzzle() async {
    return await _dio.post('/puzzle/save');
  }
}
