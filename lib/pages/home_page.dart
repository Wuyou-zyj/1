import 'dart:math';

import 'package:flutter/material.dart';
import '../route/routes.dart';
import '../models/user_inf.dart';
import '../dio/user_dio.dart';
import 'package:dio/dio.dart';

/// 首页(开始)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool start = false;

  late AnimationController _controller;

  // 自转动画
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // 动画时长
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Routes.pushForNamed(context, RoutePath.selectJigsawPuzzle);
        start = false;
      }
    });

    // 第一条鱼的自转动画
    _rotationAnimation = Tween<double>(begin: 0, end: 180).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/背景.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: centerX,
              top: centerY,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  // 计算自转角度
                  final rotationAngle = _rotationAnimation.value * (pi / 180);
                  return Transform.translate(
                    offset: Offset(-0.5 * size.width, -0.5 * size.width),
                    child: Transform.rotate(
                      angle: rotationAngle,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  height: size.width,
                  child:
                      Image.asset("assets/images/鱼2.png", fit: BoxFit.contain),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!start) {
                  _controller.forward(from: 0);
                  start = true;
                }
              },
              child: Container(
                width: size.width,
                height: size.height,
                child: Image.asset('assets/images/开始页面花.png',),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
