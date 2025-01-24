import 'package:flutter/material.dart';
import '../route/routes.dart';

/// 首页(开始)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              //Routes.push(context, const SelectJigsawPuzzle());
              Routes.pushForNamed(context, RoutePath.selectJigsawPuzzle);
            },
            child: Container(
              alignment: Alignment.center,
              child: const Text("开始",
                  style: TextStyle(color: Colors.black, fontSize: 50)),
            )));
  }
}
