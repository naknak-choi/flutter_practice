import 'package:flutter_with_mysql_practice/model/user_json_model.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Service {
  // web에 있는 json 정보
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  // http 통신을 위한 메서드
  static Future<List<User>> getInfo() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<User> user = userFromJson(response.body);
        return user;
      } else {
        // 실패할 경우
        Fluttertoast.showToast(msg: 'Error occurred. please try again');
        // 빈 리스트를 출력해준다
        return <User>[];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      return <User>[];
    }
  }
}
