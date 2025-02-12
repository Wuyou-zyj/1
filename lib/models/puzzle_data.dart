// class PuzzleDataList{
//   List<PuzzleData?>? puzzleList;
//   PuzzleDataList.fromJson(dynamic json){
//     if(json is List){
//
//       puzzleList=[];
//       for (var element in json) {
//         puzzleList?.add(PuzzleData.fromJson(element));
//       }
//     }
//   }
// }
// class PuzzleData {
//   final String name;
//   final bool completed;
//   final int id;
//   final String introduction;
//   final PuzzlePieces? pieces;
//   final String? picture;
//
//   PuzzleData({
//     required this.id,
//     required this.name,
//     required this.completed,
//     required this.introduction,
//     this.pieces,
//     this.picture,
//   });
//
//   factory PuzzleData.fromJson(Map<String, dynamic> json) {
//     return PuzzleData(
//       name: json['name'] as String,
//       completed: json['completed'] as bool,
//       id: json['id'] as int,
//       introduction: json['introduction'] as String,
//       pieces: json['pieces'] != null ? PuzzlePieces.fromJson(json['pieces']) : null,
//       picture: json['picture'] as String?,
//     );
//   }
// }
//
// class PuzzlePieces {
//   final List<String?> existing;
//   final List<String> unfinished;
//
//   PuzzlePieces({
//     required this.existing,
//     required this.unfinished,
//   });
//
//   factory PuzzlePieces.fromJson(Map<String, dynamic> json) {
//     return PuzzlePieces(
//       existing: (json['existing'] as List).map((e) => e as String?).toList(),
//       unfinished: (json['unfinished'] as List).map((e) => e as String).toList(),
//     );
//   }
// }