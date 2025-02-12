import 'package:flutter/material.dart';

class PuzzleRow extends StatelessWidget {
  final List<String?> unfinished;
  final Function(String?) onDrag;

  const PuzzleRow({
    required this.unfinished,
    required this.onDrag,
    super.key,
  }) ;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;

    // 计算每个正方形的边长
    // 总宽度 = 屏幕宽度 - 父容器左右 margin (40) - 子项之间间距总和 (3 * 10)
    double squareSize = (screenWidth - 40 - 3 * 10) / 4;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 等间距分布子项
        children: List.generate(unfinished.length, (index) {
          if(unfinished[index]==null){
            return Container();
          }
          return  Draggable<String>(
            data: unfinished[index],
            feedback: Container(
              width: squareSize,
              height: squareSize,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              color: Colors.grey.withOpacity(0.5),
              child: Center(child:Image.network(
                unfinished[index]!,
                // 'https://img.tukuppt.com/ad_preview/01/38/51/6323edba02ed5.jpg!/fw/780',
                //     "http://tohsaka.cloud/img/picture_2_13.png",
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('加载图片失败'));
                },
              )),
            ),
            onDragCompleted: () {
              onDrag(unfinished[index]);
            },
            childWhenDragging: Container(),
            child: Container(
                width: squareSize,
                height: squareSize,
                padding: const EdgeInsets.all(20),
                color: Colors.blue,
                child: Center(
                    child: Image.network(
                  unfinished[index]!,
                  // 'https://img.tukuppt.com/ad_preview/01/38/51/6323edba02ed5.jpg!/fw/780',
                  //     "http://tohsaka.cloud/img/picture_2_13.png",
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('加载图片失败'));
                  },
                ))),
          ) ;
        }),
        // children: [
        //   Container(
        //     width: squareSize, // 宽度为正方形边长
        //     height: squareSize, // 高度为正方形边长
        //     alignment: Alignment.center,
        //     color: Colors.blue, // 颜色用来区分每个子项
        //     child: Text(
        //       "未拼图0",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        //   Container(
        //     width: squareSize,
        //     height: squareSize,
        //     alignment: Alignment.center,
        //     color: Colors.green,
        //     child: Text(
        //       "未拼图1",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        //   Container(
        //     width: squareSize,
        //     height: squareSize,
        //     alignment: Alignment.center,
        //     color: Colors.orange,
        //     child: Text(
        //       "未拼图2",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        //   Container(
        //     width: squareSize,
        //     height: squareSize,
        //     alignment: Alignment.center,
        //     color: Colors.red,
        //     child: Text(
        //       "未拼图3",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
