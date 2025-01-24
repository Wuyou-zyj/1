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
          child: Column(
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
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1),
              itemBuilder: (context, index) {
                return const Text("拼图");
              },
              itemCount: 16,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(margin: EdgeInsets.only(left: 20,right: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey),
            child: Row(
              children: [
                Container(padding: EdgeInsets.all(20),child: Text("未拼图")),
                Container(padding: EdgeInsets.all(20),child: Text("未拼图")),
                Container(padding: EdgeInsets.all(20),child: Text("未拼图")),
                Container(padding: EdgeInsets.all(20),child: Text("未拼图"))
              ],
            ),
          )
        ],
      )),
    );
  }
}
