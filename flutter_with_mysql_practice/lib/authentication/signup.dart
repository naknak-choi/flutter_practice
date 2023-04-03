import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_with_mysql_practice/api/api.dart';
import 'package:flutter_with_mysql_practice/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // 유저 이메일 체크 메서드
  checkUserEmail() async {
    try {
      // 서버로 정보 보내고 저장하게 함
      var respose = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailController.text.trim(),
        },
      );
      // 플루터와 서버와의 통신만 확인하는 코드
      if (respose.statusCode == 200) {
        var responsebody = jsonDecode(respose.body);

        if (responsebody['existEmail'] == true) {
          Fluttertoast.showToast(
            msg: "Email is already in use. Please try another email",
          );
        } else {
          saveInfo();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // 사용자의 정보를 서버에 저장시키는 함수
  saveInfo() async {
    User userModle = User(
      1,
      userNameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    try {
      var res = await http.post(
        Uri.parse(API.signup),
        body: userModle.toJson(),
      );

      if (res.statusCode == 200) {
        var resSignup = jsonDecode(res.body);
        if (resSignup['success'] == true) {
          Fluttertoast.showToast(msg: 'Signup successfully');
          setState(() {
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
          });
        } else {
          Fluttertoast.showToast(msg: 'Error occurred. Please try again1');
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
                  Icons.card_travel_outlined,
                  color: Colors.deepPurple,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Sign Up',
                  style: GoogleFonts.bebasNeue(fontSize: 36.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Thank you for join us',
                    style: GoogleFonts.bebasNeue(fontSize: 28)),
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
                              controller: userNameController,
                              validator: (val) =>
                                  val == "" ? "Please enter username " : null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: 'User'),
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
                      checkUserEmail();
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
                            'Sign up',
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
                    const Text('Already registered?'),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        ' Go back Login page!',
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
