import 'package:flutter/material.dart';

class BasePageRoute extends PageRouteBuilder {
  final Widget child;

  BasePageRoute({required this.child, RouteSettings? settings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final Tween<Offset> offsetTween =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
    final Animation<Offset> slideInFromTheRightAnimation =
        offsetTween.animate(animation);
    return SlideTransition(
      position: slideInFromTheRightAnimation,
      child: child,
    );
  }
}
