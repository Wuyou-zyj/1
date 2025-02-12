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

    return Container(
      alignment: Alignment.center, // 容器内容居中对齐
      padding: const EdgeInsets.symmetric(horizontal: 20), // 左右内边距 20
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // 禁止用户滚动
        shrinkWrap: true,
        // 高度动态缩放
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 每行固定显示 4 列
          mainAxisSpacing: 5, // 主轴方向子项间距
          crossAxisSpacing: 5, // 横轴方向子项间距
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
                  alignment: Alignment.center,
                  color: Colors.blue, // 设置一个颜色以便观察布局
                  child: existing[index]==null
                      ? const Center(child: Text('待拼'))
                      : Center(
                          child: Image.network(
                          existing[index]!,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text('加载图片失败'));
                          },
                        )));
            },
          );
        },
      ),
    );
  }
}
