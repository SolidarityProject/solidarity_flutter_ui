import 'package:flutter/material.dart';

class Styles {
  static const TextStyle BLACK_TEXT = TextStyle(
    color: Colors.black,
  );

  static const TextStyle WHITE_TEXT = TextStyle(
    color: Colors.white,
  );

  static const TextStyle POST_DATE = TextStyle(
    color: Color(0xff2929a3),
    fontWeight: FontWeight.w700,
  );

  static const TextStyle POST_TITLE = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle POST_STAR_DESC = TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.blueGrey,
  );

  static const TextStyle TF_HINT = TextStyle(
    color: Colors.black45,
  );

  static const TextStyle TF_LABEL = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle TF_LABEL_WHITE = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // ignore: non_constant_identifier_names
  static BoxDecoration TF_BOXDEC = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}
