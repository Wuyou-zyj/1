import 'package:flutter/material.dart';
import '../route/routes.dart';
import '../user/user_inf.dart';
import '../dio/user_dio.dart';
import 'package:dio/dio.dart';

/// 首页(开始)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasLogin = false;
  @override
  void initState(){
    super.initState();
    //初始化
    initialize().then((_){
      if(hasLogin){
        Routes.pushForNamed(context, RoutePath.selectJigsawPuzzle);
      }else {
        Routes.pushForNamed(context, RoutePath.login);
      }
    });

  }
  ///初始化
  Future<void> initialize()async{
    User.init();
    if(User.uid.isNotEmpty&&User.token.isNotEmpty){
      try{
        Response res = await UserDio.refTk();
        if(res.data['code']==200){
          hasLogin = true;
          await User.setToken(res.data['data']);
        }else{
          hasLogin = false;
        }
      }catch(e){
        hasLogin = false;
      }
    }
    await Future.delayed(const Duration(seconds: 1));//为了调试能看得见，测试时可以删除
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            // onTap: () {
            //   //Routes.push(context, const SelectJigsawPuzzle());
            //   Routes.pushForNamed(context, RoutePath.login);
            // },
            child: Container(
              alignment: Alignment.center,
              child: const Text("开始",
                  style: TextStyle(color: Colors.black, fontSize: 50)),
            )));
  }
}
