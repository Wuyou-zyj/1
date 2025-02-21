import 'package:culture_popularization_app/data/puzzle_vm.dart';
import 'package:culture_popularization_app/dio/puzzle_get_dio.dart';
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
  late int widgetId;

  ///
  bool successDrop = false;
  bool first=true;

  ///拼图块
  // List<String?> existing = [
  //   "http://tohsaka.cloud/img/picture_2_1.png",
  //   "http://tohsaka.cloud/img/picture_2_2.png",
  //   "http://tohsaka.cloud/img/picture_2_3.png",
  //   "http://tohsaka.cloud/img/picture_2_4.png",
  //   null,
  //   null,
  //   null,
  //   null,
  //   "http://tohsaka.cloud/img/picture_2_9.png",
  //   "http://tohsaka.cloud/img/picture_2_10.png",
  //   "http://tohsaka.cloud/img/picture_2_11.png",
  //   "http://tohsaka.cloud/img/picture_2_12.png",
  //   "http://tohsaka.cloud/img/picture_2_13.png",
  //   "http://tohsaka.cloud/img/picture_2_14.png",
  //   "http://tohsaka.cloud/img/picture_2_15.png",
  //   "http://tohsaka.cloud/img/picture_2_16.png"
  // ];
  // List<String?> unfinished = [
  //   "http://tohsaka.cloud/img/picture_2_5.png",
  //   "http://tohsaka.cloud/img/picture_2_6.png",
  //   // null,
  //   // null,
  //   // null,
  //   // null,
  //   "http://tohsaka.cloud/img/picture_2_7.png",
  //   "http://tohsaka.cloud/img/picture_2_8.png"
  // ];

  List<String?> existing = [];
  List<String?> unfinished = [];
  String? picture;
  List<int> unfinishedIdList = [-1, -1, -1, -1]; //传给后端的


  PuzzleViewModel puzzleViewModel = PuzzleViewModel();

  @override
  void initState() {
    super.initState();
    widgetId = widget.id;
    puzzleViewModel.getPuzzle();
  }

  int getPuzzleId(String url) {
    // 查找 "_" 和 ".png" 之间的内容
    int start = url.lastIndexOf('_') + 1;
    int end = url.lastIndexOf('.');
    return int.parse(url.substring(start, end));
  }

  void getUnFinishedIdList(int id) {
    int index = 4 * id - 4;
    for (int i = index; i < index + 4; i++) {
      if(existing.isNotEmpty){
        if (existing[i] == null) {
          unfinishedIdList[i - index] = -1;
        } else {
          unfinishedIdList[i - index] = getPuzzleId(existing[i]!);
        }
      }
    }
  }

  void setUnFinishedIdList(int index, int puzzleId) {
    int i = index - 4 * widget.id + 4;
    unfinishedIdList[i] = puzzleId;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PuzzleViewModel>(
      create: (context) {
        return puzzleViewModel;
      },
      child: Scaffold(body: Consumer<PuzzleViewModel>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/背景.jpg"),
                  fit: BoxFit.cover,
                ),
              ),child: Container(decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/拼图界面.png"),
                fit: BoxFit.cover,
              ),
            )),
            );
          }
          final size = MediaQuery.of(context).size;
          final r = size.width / 370;
          bool completed = value.puzzleList?[widget.id - 1]!.completed ?? false;
          PuzzleData? puzzleData = value.puzzleList?[widget.id - 1];

          if (puzzleData != null) {
            if (completed) {
              picture = value.puzzleList?[widget.id - 1]?.picture ;
              print(picture);
            } else {
              existing = puzzleData.pieces?.existing ?? [];
              unfinished = puzzleData.pieces?.unfinished ?? [];
            }
          }
          if (!completed) getUnFinishedIdList(widget.id);
          print(unfinishedIdList);

          return SafeArea(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/背景.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/拼图界面.png"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        if(!completed){
                          if(first){
                            showDialog(

                                context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey.withOpacity(0.8),
                                content: Container(
                                  // color: Colors.grey.withOpacity(0.5),

                                  height: 100*r,
                                  alignment: Alignment.center,
                                  child:Text('您还没有保存，确定要退出吗！'),
                                ),
                              );
                            });
                            first=false;
                          }else{
                            value.exit(widgetId);
                            Routes.pop(context);
                          }

                        }else{
                          value.exit(widgetId);
                          Routes.pushReplacementNamed(context,RoutePath.selectJigsawPuzzle);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 10 * r, top: 0, right: 0, bottom: 0),
                        padding: EdgeInsets.only(
                            left: 15 * r,
                            top: 3 * r,
                            right: 15 * r,
                            bottom: 3 * r),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20 * r)),
                        child: Text(
                          "退出",
                          style: TextStyle(fontSize: 15 * r),
                        ),
                      ),
                    ),
                    completed
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: Center(
                                        child: Column(
                                      children: [
                                        const Text('年画介绍'),
                                        Divider(
                                          height: 2 * r,
                                          thickness: 3,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    )),
                                    content: SingleChildScrollView(
                                      child: Text(
                                        puzzleData?.introduction ?? '',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(0.1 * size.width),
                              padding: EdgeInsets.only(
                                  left: 5 * r,
                                  top: 3 * r,
                                  right: 5 * r,
                                  bottom: 3 * r),
                              alignment: Alignment.center,
                              width: 0.5 * size.width,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(15 * r)),
                              child: Text("年画介绍",
                                  style: TextStyle(fontSize: 25 * r)),
                            ),
                          )
                        : SizedBox(height: 0.2 * size.width)
                  ]),
                  SizedBox(
                    height: 20 * r,
                  ),
                  //原来的代码存在界面尺寸改变导致行数或列数改变
                  completed
                      ? Container(
                          width: 300 * r,
                          height: 300 * r,
                          child: Image.network(
                            picture!,
                            fit: BoxFit.contain,
                          ),
                        )
                      : PuzzleGrid(
                          existing: existing,
                          unfinished: unfinished,
                          onDrop: (index, piece) async {
                            print(index);
                            print(piece);
                            int pieceId = getPuzzleId(piece!);
                            print(pieceId);
                            if (index <= 4 * widgetId - 1 &&
                                index >= 4 * widgetId - 4) {
                              successDrop = true;
                              setUnFinishedIdList(index, pieceId);
                              existing[index]=piece;
                              unfinished.remove(piece);
                              await ApiClient.instance
                                  .movePuzzle(widgetId, unfinishedIdList);
                              await value.getPuzzle();
                            }

                            print(unfinishedIdList);
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
                  SizedBox(
                    height: 20 * r,
                  ),
                  completed? SizedBox():Container(
                    margin: EdgeInsets.all(10 * r),
                    padding: EdgeInsets.all(5 * r),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(onTap: (){
                              print('重新开始');
                              value.refresh(widgetId);

                            }, child: Container(
                              margin: EdgeInsets.all(5 * r),
                              padding:
                              EdgeInsets.only(left: 5 * r, right: 5 * r),
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                      color: Colors.orange, width: 2 * r),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                              child: Text(
                                "重新开始",
                                style: TextStyle(fontSize: 15 * r),
                              ),
                            ),),
                            GestureDetector(onTap: (){
                              print('撤销移动');
                              value.withDraw(widgetId);

                            },child: Container(
                              margin: EdgeInsets.all(5 * r),
                              padding:
                              EdgeInsets.only(left: 5 * r, right: 5 * r),
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                      color: Colors.orange, width: 2 * r)),
                              child: Text(
                                "撤销移动",
                                style: TextStyle(fontSize: 15 * r),
                              ),
                            ),),
                            GestureDetector(onTap: (){
                              print('保存');
                              value.save(widgetId);
                              first=false;

                            },child: Container(
                              margin: EdgeInsets.all(5 * r),
                              padding: EdgeInsets.only(right: 5 * r),
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                      color: Colors.orange, width: 2 * r),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20))),
                              child: Text(
                                "    保存    ",
                                style: TextStyle(fontSize: 15 * r),
                              ),
                            ),)
                          ],
                        ),
                        PuzzleRow(
                            unfinished: unfinished,
                            onDrag: (piece) {
                              if (successDrop) {
                                print('移动成功');
                                successDrop = false; // 移除已被拖动的拼图块
                              }
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      )),
    );
  }
}
