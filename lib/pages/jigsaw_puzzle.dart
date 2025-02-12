import 'package:culture_popularization_app/data/puzzle_vm.dart';
import 'package:culture_popularization_app/widgets/puzzle_grid.dart';
import 'package:culture_popularization_app/widgets/puzzle_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/puzzle.dart';
import '../route/routes.dart';

///拼图页面
class JigsawPuzzle extends StatefulWidget {
  final int id;

  const JigsawPuzzle({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return _JigsawPuzzleState();
  }
}

class _JigsawPuzzleState extends State<JigsawPuzzle> {
  ///
  bool successDrop = false;

  ///拼图块
  List<String?> existing = [
    "http://tohsaka.cloud/img/picture_2_1.png",
    "http://tohsaka.cloud/img/picture_2_2.png",
    "http://tohsaka.cloud/img/picture_2_3.png",
    "http://tohsaka.cloud/img/picture_2_4.png",
    null,
    null,
    null,
    null,
    "http://tohsaka.cloud/img/picture_2_9.png",
    "http://tohsaka.cloud/img/picture_2_10.png",
    "http://tohsaka.cloud/img/picture_2_11.png",
    "http://tohsaka.cloud/img/picture_2_12.png",
    "http://tohsaka.cloud/img/picture_2_13.png",
    "http://tohsaka.cloud/img/picture_2_14.png",
    "http://tohsaka.cloud/img/picture_2_15.png",
    "http://tohsaka.cloud/img/picture_2_16.png"
  ];
  List<String?> unfinished = [
    "http://tohsaka.cloud/img/picture_2_5.png",
    // "http://tohsaka.cloud/img/picture_2_6.png",
    null,
    // null,
    "http://tohsaka.cloud/img/picture_2_7.png",
    "http://tohsaka.cloud/img/picture_2_8.png"
  ];
  // List<String?> existing = [];
  // List<String?> unfinished = [];
  String? picture;
  List<int> puzzleIdList=[-1,-1,-1,-1];

  PuzzleViewModel puzzleViewModel = PuzzleViewModel();

  @override
  void initState() {
    super.initState();
    puzzleViewModel.getPuzzle();
  }
  int getPuzzleId(String url){
    // 查找 "_" 和 ".png" 之间的内容
    int start = url.lastIndexOf('_') + 1;
    int end = url.lastIndexOf('.');
    return int.parse(url.substring(start, end));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PuzzleViewModel>(
      create: (context) {
        return puzzleViewModel;
      },
      child: Scaffold(body: Consumer<PuzzleViewModel>(
        builder: (context, value, child) {
          bool completed = value.puzzleList?[widget.id]!.completed ?? false;
          PuzzleData? puzzleData = value.puzzleList?[widget.id];

          if (puzzleData != null) {
            if (completed) {
               picture = value.puzzleList?[widget.id]?.picture;
               print(picture);
            } else {
              existing = puzzleData.pieces?.existing ?? [];
              unfinished = puzzleData.pieces?.unfinished ?? [];
            }
          }
          //
          // for (int i = 0; i < unfinished.length; i++) {
          //   if (unfinished[i] != null) {
          //     var puzzleId = getPuzzleId(unfinished[i]!);
          //     if (!puzzleIdList.contains(puzzleId)) {
          //       puzzleIdList.add(puzzleId);
          //     }
          //   }
          // }
          //   print("puzzleIdList");
          //   print(puzzleIdList);

          return SafeArea(
              child: ListView(
            children: [
              Row(children: [
                GestureDetector(
                  onTap: () {
                    Routes.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text(
                      "退出",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                completed
                    ? Container(
                        margin: const EdgeInsets.only(right: 60),
                        alignment: Alignment.center,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child:
                            const Text("年画介绍", style: TextStyle(fontSize: 30)),
                      )
                    : const SizedBox()
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text("重新开始", style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text("撤销移动", style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text("保存", style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              //原来的代码存在界面尺寸改变导致行数或列数改变
              PuzzleGrid(
                existing: existing,
                unfinished: unfinished,
                onDrop: (index, piece) {
                  print(index);
                  print(piece);
                  int pieceId=getPuzzleId(piece!);
                  for(int i =0;i<index;i++){

                  }
                }

                  // if (existing[index] == null) {
                  //   successDrop = true;
                  //   setState(() {
                  //     existing[index] = piece;
                  //   });
                  // } else {
                  //   successDrop = false;
                  // }
                // },
              ),
              const SizedBox(
                height: 20,
              ),
              PuzzleRow(
                  unfinished: unfinished,
                  onDrag: (piece) {
                    if (successDrop) {
                      unfinished.remove(piece); // 移除已被拖动的拼图块
                      setState(() {});
                    }
                  })
            ],
          ));
        },
      )),
    );
  }
}
