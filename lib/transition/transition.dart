import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class Transition extends PageRouteBuilder {
  final Widget child;

  Transition.f(this.child)
      : super(
          pageBuilder: (context, animation, secAnimation) {
            return child;
          },
          maintainState: false,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> seAnimation,
              widget) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeOutQuint);
            return CircularRevealAnimation(
              child: widget,
              animation: animation,
              centerAlignment: Alignment.bottomRight,
            );
          },
          transitionDuration: Duration(milliseconds: 900),
        );

  Transition.s(this.child)
      : super(
          pageBuilder: (context, animation, secAnimation) {
            return child;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> seAnimation,
              widget) {
            return FadeTransition(
              child: widget,
              opacity: animation,
            );
          },
          transitionDuration: Duration(milliseconds: 900),
        );
}
