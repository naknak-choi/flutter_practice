import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<int> numbers = [];
  bool isViewed = true;

  void onclicked() {
    setState(() {
      isViewed = !isViewed;
    });
  }

  // build 는 위젯의 UI라고 할 수 있고 여기 안에 있는 걸 화면에 그려준다는 거임
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isViewed ? const MyLargeTitle() : const Text('notification'),
              IconButton(
                  onPressed: onclicked, icon: const Icon(Icons.remove_red_eye))
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    Key? key,
  }) : super(key: key);

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  @override
  void initState() {
    super.initState();
    print('init!!');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose!!');
  }

  @override
  Widget build(BuildContext context) {
    print('build!!');
    return Text(
      'My Large Title',
      style: TextStyle(
          fontSize: 30, color: Theme.of(context).textTheme.titleLarge?.color),
    );
  }
}
