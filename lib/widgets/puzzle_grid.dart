import 'package:flutter/material.dart';

class PuzzleGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center, // 容器内容居中对齐
      padding: EdgeInsets.symmetric(horizontal: 20), // 左右内边距 20
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(), // 禁止用户滚动
        shrinkWrap: true, // 高度动态缩放
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 每行固定显示 4 列
          mainAxisSpacing: 5, // 主轴方向子项间距
          crossAxisSpacing: 5, // 横轴方向子项间距
          childAspectRatio: 1, // 子项宽高比设置为 1，使其为正方形
        ),
        itemBuilder: (context, index) {
          // 构建网格子项
          return Container(
            alignment: Alignment.center,
            color: Colors.blue, // 设置一个颜色以便观察布局
            child: Text(
              "拼图",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
        itemCount: 16, // 固定生成 16 个子项
      ),
    );
  }
}
