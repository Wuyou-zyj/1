import 'package:culture_popularization_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

import '../models/puzzle.dart';

class ApiClient {
  static ApiClient instance = ApiClient._();
  ApiClient._();


  Future<List<PuzzleData?>?> getPuzzleInfo() async {
    Response response= await DioInstance.instance().get(path: 'puzzle/get');
    PuzzleDataList puzzleDataList=PuzzleDataList.fromJson(response.data);
    return puzzleDataList.puzzleList;
  }

  Future<bool> movePuzzle(int puzzleId, List<int> unfinished) async {
    Response response= await DioInstance.instance().post(path: 'puzzle/move', data: {
      'puzzleId': puzzleId,
      'unfinished': unfinished,
    });
    return response.data;
  }

  Future<Response> withdrawMove(int puzzleId) async {
      Response response= await DioInstance.instance().post(path: 'puzzle/withdraw',data:puzzleId);
      return response;
  }

  Future refreshPuzzle(int puzzleId) async {
    return await DioInstance.instance().post(path: 'puzzle/refresh',data: puzzleId);
  }

  Future<Response> savePuzzle(int puzzleId) async {
    return await DioInstance.instance().post(path: 'puzzle/save',data: puzzleId);
  }
  Future<Response> exit(int puzzleId)async{

    return await DioInstance.instance().post(path: 'puzzle/exit',data:puzzleId);
  }
}

