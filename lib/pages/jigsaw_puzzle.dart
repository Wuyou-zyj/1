import 'package:culture_popularization_app/widgets/puzzle_grid.dart';
import 'package:culture_popularization_app/widgets/puzzle_row.dart';
import 'package:flutter/material.dart';

import '../route/routes.dart';

///拼图页面
class JigsawPuzzle extends StatefulWidget {
  const JigsawPuzzle({super.key});

  @override
  State<StatefulWidget> createState() {
    return _JigsawPuzzleState();
  }
}

class _JigsawPuzzleState extends State<JigsawPuzzle> {
  ///是否显示年画介绍
  bool complete = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Row(children: [
            GestureDetector(onTap: (){
              Routes.pop(context);
            },
                child: Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Text(
                "退出",
                style: TextStyle(fontSize: 30),
              ),
            ),),
            const Expanded(child: SizedBox()),
            complete
                ? Container(
                    margin: const EdgeInsets.only(right: 60),
                    alignment: Alignment.center,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text("年画介绍", style: TextStyle(fontSize: 30)),
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
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text("重新开始", style: TextStyle(fontSize: 20)),
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text("撤销移动", style: TextStyle(fontSize: 20)),
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text("保存", style: TextStyle(fontSize: 20)),
                decoration: const BoxDecoration(color: Colors.grey),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          //原来的代码存在界面尺寸改变导致行数或列数改变
          PuzzleGrid(),
          SizedBox(
            height: 20,
          ),
          PuzzleRow()
        ],
      )),
    );
  }
}
