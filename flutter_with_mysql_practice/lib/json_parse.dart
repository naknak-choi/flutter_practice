import 'package:flutter/material.dart';
import 'package:flutter_with_mysql_practice/model/user_json_model.dart';
import 'service.dart';

class JsonParse extends StatefulWidget {
  const JsonParse({super.key});

  @override
  State<JsonParse> createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {
  List<User> _user = <User>[];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Service.getInfo().then((value) => (value) {
          setState(() {
            _user = value;
            loading = true;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'User' : 'Loading...'),
      ),
      body: ListView.builder(
        itemCount: _user.length,
        itemBuilder: (context, index) {
          User user = _user[index];
          return ListTile(
            leading: const Icon(
              Icons.account_circle_rounded,
              color: Colors.blue,
            ),
            title: Text(user.name),
            trailing: const Icon(
              Icons.phone_android_outlined,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
