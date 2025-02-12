import 'package:culture_popularization_app/data/puzzle_vm.dart';
import 'package:culture_popularization_app/pages/jigsaw_puzzle.dart';
import 'package:culture_popularization_app/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


///选择拼图页面
class SelectJigsawPuzzle extends StatefulWidget {
  const SelectJigsawPuzzle({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SelectJigsawPuzzleState();
  }
}

class _SelectJigsawPuzzleState extends State<SelectJigsawPuzzle> {
  PuzzleViewModel puzzleViewModel=PuzzleViewModel();

  @override
  void initState()  {
    super.initState();
    puzzleViewModel.getPuzzle();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PuzzleViewModel>(create: (context){
      return puzzleViewModel;
    },child: Scaffold(
        body: Consumer<PuzzleViewModel>(builder: (context,value,child){
          return SafeArea(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  String? name = value.puzzleList?[index]?.name;
                  bool completed=value.puzzleList?[index]?.completed??false;
                  return GestureDetector(
                      onTap: () {
                        Routes.push(context,JigsawPuzzle(id: index));
                        print("选择年画$index");
                      },
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(color: Colors.grey),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                width: 200,
                                child:  Text(
                                  name!,
                                  style: const TextStyle(color: Colors.black, fontSize: 20),
                                )),
                            Container(width: 2, height: 100, color: Colors.black),
                            Container(alignment: Alignment.center, child:completed ? const Text("已完成"):const Text("未完成"))
                          ],
                        ),
                      ));
                },
                itemCount: value.puzzleList?.length??0,
              ));

        },)),);
  }

  // Widget _listItemView(int index) {
  //
  //   return GestureDetector(
  //       onTap: () {
  //         Routes.push(context, const JigsawPuzzle());
  //         print("选择年画$index");
  //       },
  //       child: Container(
  //         height: 100,
  //         margin: const EdgeInsets.all(15),
  //         decoration: const BoxDecoration(color: Colors.grey),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(
  //                 alignment: Alignment.center,
  //                 width: 200,
  //                 child: const Text(
  //                   name!,
  //                   style: TextStyle(color: Colors.black, fontSize: 20),
  //                 )),
  //             Container(width: 2, height: 100, color: Colors.black),
  //             Container(alignment: Alignment.center, child:completed ? const Text("已完成"):const Text("未完成"))
  //           ],
  //         ),
  //       ));
  // }
}
