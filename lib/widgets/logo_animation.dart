import 'package:flutter/material.dart';

class LogoAnimation extends StatefulWidget {
  @override
  _LogoAnimationState createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        child: Image.asset(
          "assets/images/icon_mobile.png",
          width: 46.6,
          height: 46.6,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 9.8,
            child: child,
          );
        },
      ),
    );
  }
}
