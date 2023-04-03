import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seconds = 1500;
  bool isRunning = false;
  int pomodorCnt = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (seconds == 0) {
      setState(() {
        pomodorCnt++;
        seconds = 1500;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        seconds = seconds - 1;
      });
    }
  }

  void startOnpressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void pauseBtnPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void replayPressed() {
    setState(() {
      seconds = 1500;
      isRunning = false;
    });
    timer.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(seconds),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isRunning ? pauseBtnPressed : startOnpressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outlined
                        : Icons.play_circle_outline),
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                  ),
                  IconButton(
                      onPressed: replayPressed,
                      icon: const Icon(Icons.replay),
                      iconSize: 50,
                      color: Theme.of(context).cardColor),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      // borderRadius: BorderRadius.circular(40),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodors',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                        Text(
                          '$pomodorCnt',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
