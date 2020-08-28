import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff9999e6),
            Color(0xff8484e1),
            Color(0xff6f6fdc),
            Color(0xff5b5bd7),
          ],
          stops: [0.1, 0.4, 0.7, 0.8],
        ),
      ),
    );
  }
}
