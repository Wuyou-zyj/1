import 'package:culture_popularization_app/dio/puzzle_get_dio.dart';
import 'package:dio/dio.dart';

import '../models/puzzle.dart';
import 'package:flutter/foundation.dart';

class PuzzleViewModel with ChangeNotifier {
  List<PuzzleData?>? puzzleList;
  bool? completed;
  bool isLoading = true;

  Future getPuzzle() async {
    isLoading = true;
    List<PuzzleData?>? list = await ApiClient.instance.getPuzzleInfo();
    puzzleList = list ?? [];
    isLoading = false;
    notifyListeners();
  }

  Future movePuzzle(int puzzleId, List<int> unfinished) async {
    completed = await ApiClient.instance.movePuzzle(puzzleId, unfinished);
    notifyListeners();
  }

  Future withDraw(int puzzleId) async {
    Response response = await ApiClient.instance.withdrawMove(puzzleId);

    if (response.data is String) {
      return;
    }
    Pieces pieces = Pieces.fromJson(response.data);
    puzzleList?[puzzleId - 1]?.pieces = pieces;
    notifyListeners();
  }

  Future refresh(int puzzleId) async {
    await ApiClient.instance.refreshPuzzle(puzzleId);
    getPuzzle();
  }
  Future exit(int puzzleId)async{
    await ApiClient.instance.exit(puzzleId);
  }
  Future save(int puzzleId)async{
    await ApiClient.instance.savePuzzle(puzzleId);
  }
}
