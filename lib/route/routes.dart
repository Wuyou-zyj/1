import 'package:culture_popularization_app/pages/home_page.dart';
import 'package:culture_popularization_app/pages/login_page.dart';
import 'package:culture_popularization_app/pages/select_jigsaw_puzzle.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  ///动态跳转
  static Future push(BuildContext context, Widget page,
      {RouteSettings? settings}) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (_) => page, settings: settings));
  }

  ///根据路由路径跳转
  static Future pushForNamed(BuildContext context, String name,
      {Object? argument}) {
    return Navigator.pushNamed(context, name, arguments: argument);
  }

  ///关闭页面
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  ///关闭页面+传值
  static void popOfData<T extends Object?>(BuildContext context, {T? data}) {
    Navigator.of(context).pop(data);
  }

  /// 路由管理
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return pageRoute(const HomePage());
      case RoutePath.selectJigsawPuzzle:
        return pageRoute(const SelectJigsawPuzzle());
      case RoutePath.login:
        return pageRoute(const Login());
    }
    return pageRoute(const Scaffold(body: Center(child: Text("路由不存在"))));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
  }) {
    return MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: settings);
  }
}

///路由地址
class RoutePath {
  ///首页
  static const String home = "/";

  ///选择拼图页面
  static const String selectJigsawPuzzle = "/select_jigsaw_puzzle";

  ///登录页面
  static const String login = "/login";
}
