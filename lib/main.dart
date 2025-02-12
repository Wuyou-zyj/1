import 'package:culture_popularization_app/dio/dio_instance.dart';
import 'package:culture_popularization_app/route/routes.dart';
import 'package:flutter/material.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: "http://47.96.150.75:8080/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
