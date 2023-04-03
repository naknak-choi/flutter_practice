import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_with_mysql_practice/api/api.dart';
import 'package:flutter_with_mysql_practice/model/user.dart';
import 'package:flutter_with_mysql_practice/user/pages/main_screen.dart';
import 'package:flutter_with_mysql_practice/user/user_pref.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  userLogin() async {
    try {
      var res = await http.post(Uri.parse(API.login), body: {
        'user_email': emailController.text.trim(),
        'user_password': passwordController.text.trim()
      });
      if (res.statusCode == 200) {
        var resLogin = jsonDecode(res.body);
        if (resLogin['success'] == true) {
          Fluttertoast.showToast(msg: 'Login successfully');
          // 로그인 한 특정 유저의 데이터를 기억하기 위한 것
          User userInfo = User.fromJson(resLogin['userData']);

          await RememberUser.saveRememberUserInfo(userInfo);

          Get.to(const MainScreen());

          setState(() {
            emailController.clear();
            passwordController.clear();
          });
        } else {
          Fluttertoast.showToast(msg: 'Please check your email and password');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Error occurred. Please try again2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.phone_android,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Hello',
                  style: GoogleFonts.bebasNeue(fontSize: 36.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: emailController,
                              validator: (val) =>
                                  val == "" ? "Please enter email" : null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: passwordController,
                              validator: (val) =>
                                  val == "" ? "Please enter password" : null,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      userLogin();
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    GestureDetector(
                      onTap: () => Get.to(() => const SignupPage()),
                      child: const Text(
                        ' Register Now!',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
