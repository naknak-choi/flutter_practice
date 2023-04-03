import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  // ID처럼 쓰이는 key - widget을 파악하는데 쓰인다.
  const App({super.key});

  // build 는 위젯의 UI라고 할 수 있고 여기 안에 있는 걸 화면에 그려준다는 거임
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
