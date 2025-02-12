import 'package:culture_popularization_app/dio/puzzle_get_dio.dart';

import '../models/puzzle.dart';
import 'package:flutter/foundation.dart';

class PuzzleViewModel with ChangeNotifier {
  List<PuzzleData?>? puzzleList;
  bool? completed;

  Future getPuzzle() async {
    List<PuzzleData?>? list = await ApiClient.instance.getPuzzleInfo();
    puzzleList = list ?? [];
    notifyListeners();
  }

  Future movePuzzle(int puzzleId,List<int> unfinished)async{
    completed = await  ApiClient.instance.movePuzzle(puzzleId, unfinished);
    notifyListeners();
  }

}
