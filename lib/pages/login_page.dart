import 'package:culture_popularization_app/dio/user_dio.dart';
import 'package:culture_popularization_app/models/user_inf.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../route/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _usernameController = TextEditingController(text: User.sid);
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  bool hasLogin = false;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> initialize() async {
  //   User.init();
  //   if (User.uid != -1 && User.token.isNotEmpty) {
  //     try {
  //       Response res = await UserDio.refTk();
  //       if (res.data['code'] == 200) {
  //         hasLogin = true;
  //         await User.setToken(res.data['data']);
  //       } else {
  //         hasLogin = false;
  //       }
  //     } catch (e) {
  //       hasLogin = false;
  //     }
  //   }
  // }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/背景.jpg'), fit: BoxFit.cover)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(
                    "欢迎",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          // hintText: '学号',
                          // filled: true,
                          labelText: '学号',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          fillColor: Color(0xFFF5FCF9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            labelText: '密码',
                            labelStyle: TextStyle(color: Colors.white),
                            // hintText: '密码',
                            // filled: true,
                            fillColor: Color(0xFFF5FCF9),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      _errorMessage.isEmpty
                          ? SizedBox(
                              height: constraints.maxHeight * 0.03,
                            )
                          : SizedBox(
                              height: constraints.maxHeight * 0.03,
                              child: Text(
                                _errorMessage,
                                style:
                                    const TextStyle(color: Colors.greenAccent),
                              ),
                            ),
                      SizedBox(height: constraints.maxHeight * 0.03,),
                      ElevatedButton(
                        onPressed: () async {
                          String id = _usernameController.text;
                          String pwrd = _passwordController.text;
                          if (id.isEmpty || pwrd.isEmpty) {
                            setState(() {
                              _errorMessage = "请输入学号和密码";
                            });
                            return;
                          }
                          setState(() {
                            _errorMessage = "请稍后... ";
                          });
                          try {
                            Response res = await UserDio.signin(id, pwrd);

                            if (res.statusCode == 200) {
                              if (res.data['code'] == 200) {
                                await User.setInf(
                                    id,
                                    res.data['data']['user']['uid'],
                                    pwrd,
                                    res.data['data']['token']);
                                await User.init();
                                Routes.pushReplacementNamed(
                                    context, RoutePath.home);
                              } else {
                                setState(() {
                                  _errorMessage = '账号或密码错误';
                                });
                              }
                            }
                          } catch (e) {
                            setState(() {
                              _errorMessage = '网络异常';
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              const Color(0xFF00BF6D).withOpacity(0),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("登录"),
                      ),
                      const SizedBox(height: 16.0),
                      // TextButton(
                      //   onPressed: () {
                      //     Routes.pushReplacementNamed(
                      //         context, RoutePath.selectJigsawPuzzle);
                      //     // Routes.push(context, const JigsawPuzzle(id: 1));
                      //     // Routes.pushForNamed(context, RoutePath.home);
                      //   },
                      //   child: Text(
                      //     '暂不登录?',
                      //     style: Theme
                      //         .of(context)
                      //         .textTheme
                      //         .bodyMedium!
                      //         .copyWith(
                      //       color: Theme
                      //           .of(context)
                      //           .textTheme
                      //           .bodyLarge!
                      //           .color!
                      //           .withOpacity(0.64),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
