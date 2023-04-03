import 'package:flutter/material.dart';
import 'package:flutter_with_mysql_practice/responsive/breakpoint.dart';

class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    this.maxContentWidth = BreakPoint.tablet,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  final double maxContentWidth;
  // 위젯에 inner padding과 outer padding을 주기 위해서 사용
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // max가 maxContentWidth라는 tight constraints라는 속성을 가진다.
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          // 그래서 이 child는 maxContentWidth라는 제약사항을 가지게 되는데 만약에 이보다 커질 경우 컨텐츠는 중앙에 위치하게 된다.
          child: child,
        ),
      ),
    );
  }
}
