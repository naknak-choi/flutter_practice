import 'package:flutter/material.dart';
import 'package:flutter_with_mysql_practice/authentication/signup.dart';
import 'package:flutter_with_mysql_practice/responsive/breakpoint.dart';
import 'package:flutter_with_mysql_practice/responsive/responsive_center.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Center responsive'),
      ),
      body: const ResponsiveCenter(
        maxContentWidth: BreakPoint.deskTop,
        padding: EdgeInsets.all(16),
        child: SignupPage(),
      ),
    );
  }
}
