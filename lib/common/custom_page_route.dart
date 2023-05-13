import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;
  final String routeName;

  CustomPageRoute({required this.builder, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
