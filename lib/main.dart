import 'package:culture_popularization_app/dio/dio_instance.dart';
import 'package:culture_popularization_app/route/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio/user_dio.dart';
import 'models/user_inf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioInstance.instance().initDio(baseUrl: "http://47.96.150.75:8080/");
  // 检查 token
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token_f');
  String initialRoute = RoutePath.login;

  try{

    if (token != null&&token.isNotEmpty) {

      Response response= await UserDio.refTk();

      await User.setToken(response.data);
      initialRoute = RoutePath.home;


    }

    runApp(MyApp(initialRoute: initialRoute));

  }catch(e){
    runApp(MyApp(initialRoute: initialRoute));
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culture Popularization',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutePath.home,
    );
  }
}