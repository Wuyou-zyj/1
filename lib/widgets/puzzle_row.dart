import 'package:flutter/material.dart';

class PuzzleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;

    // 计算每个正方形的边长
    // 总宽度 = 屏幕宽度 - 父容器左右 margin (40) - 子项之间间距总和 (3 * 10)
    double squareSize = (screenWidth - 40 - 3 * 10) / 4;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 等间距分布子项
        children: [
          Container(
            width: squareSize, // 宽度为正方形边长
            height: squareSize, // 高度为正方形边长
            alignment: Alignment.center,
            color: Colors.blue, // 颜色用来区分每个子项
            child: Text(
              "未拼图",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: squareSize,
            height: squareSize,
            alignment: Alignment.center,
            color: Colors.green,
            child: Text(
              "未拼图",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: squareSize,
            height: squareSize,
            alignment: Alignment.center,
            color: Colors.orange,
            child: Text(
              "未拼图",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: squareSize,
            height: squareSize,
            alignment: Alignment.center,
            color: Colors.red,
            child: Text(
              "未拼图",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
