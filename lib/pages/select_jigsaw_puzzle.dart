import 'package:culture_popularization_app/pages/jigsaw_puzzle.dart';
import 'package:culture_popularization_app/route/routes.dart';
import 'package:flutter/material.dart';

///选择拼图页面
class SelectJigsawPuzzle extends StatefulWidget {
  const SelectJigsawPuzzle({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SelectJigsawPuzzleState();
  }
}

class _SelectJigsawPuzzleState extends State<SelectJigsawPuzzle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView.builder(
      itemBuilder: (context, index) {
        return _listItemView(index);
      },
      itemCount: 10,
    )));
  }

  Widget _listItemView(int index) {
    return GestureDetector(onTap: (){
        Routes.push(context, const JigsawPuzzle());
      print("选择年画$index");
    },child: Container(
      height: 100,
      margin: const EdgeInsets.all(15),
      decoration:  const BoxDecoration(color: Colors.grey),
      child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              alignment: Alignment.center,
              width: 200,
              child: const Text(
                "年画名称",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
          Container(width: 2, height: 100, color: Colors.black),
          Container(alignment: Alignment.center, child: const Text("是否完成"))
        ],
      ),
    ));
  }
}
