import 'dart:convert';

import 'package:flutter_with_mysql_practice/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// shared preferences는 사용자의 정보를 내 컴퓨터에 저장시키는 것.
class RememberUser {
  static Future<void> saveRememberUserInfo(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // 유저의 정보를 json 포멧으로 인코딩 해주었다.
    // json 형태로 사용자의 정보가 로컬 디스크에 저장된다.
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }
}
