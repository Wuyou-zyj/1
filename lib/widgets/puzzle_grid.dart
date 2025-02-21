import 'package:flutter/material.dart';

class PuzzleGrid extends StatelessWidget {
  final List<String?> existing;
  final List<String?> unfinished;
  final Function(int, String?) onDrop;

  const PuzzleGrid({
    required this.existing,
    required this.unfinished,
    required this.onDrop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;
    double r=screenWidth/370;

    return Container(
      width: 300*r,
      height: 300*r,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center, // 容器内容居中对齐
      padding: const EdgeInsets.symmetric(horizontal: 20), // 左右内边距 20
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // 禁止用户滚动
        shrinkWrap: true,
        // 高度动态缩放
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 每行固定显示 4 列
          mainAxisSpacing: 1, // 主轴方向子项间距
          crossAxisSpacing: 1, // 横轴方向子项间距
          childAspectRatio: 1, // 子项宽高比设置为 1，使其为正方形
        ),
        itemCount: existing.length,
        itemBuilder: (context, index) {
          // 构建网格子项
          return DragTarget<String>(
            onAccept: (piece) {
              onDrop(index, piece);
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 75*r,
                  height: 75*r,
                  // alignment: Alignment.center,
                  // color: Colors.blue, // 设置一个颜色以便观察布局
                  child: existing[index]==null
                      ? const Center()
                      :
                          Image.network(
                          existing[index]!,fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text('加载图片失败'));
                          },
                        ));
            },
          );
        },
      ),
    );
  }
}
