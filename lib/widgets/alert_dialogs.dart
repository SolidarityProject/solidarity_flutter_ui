import 'package:flutter/material.dart';

class AlertDialogOneButton extends StatelessWidget {
  final String title;
  final String content;
  final String okText;
  final Function okOnPressed;

  AlertDialogOneButton({
    this.title,
    this.content,
    this.okText,
    this.okOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        _alertDiaologFlatButton(context, okText, okOnPressed),
      ],
    );
  }
}

class AlertDialogTwoButtons extends StatelessWidget {
  final String title;
  final String content;
  final String yesText;
  final String noText;
  final Function yesOnPressed;
  final Function noOnPressed;

  AlertDialogTwoButtons({
    this.title,
    this.content,
    this.yesText,
    this.noText,
    this.yesOnPressed,
    this.noOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        _alertDiaologFlatButton(context, noText, noOnPressed),
        _alertDiaologFlatButton(context, yesText, yesOnPressed),
      ],
    );
  }
}

Widget _alertDiaologFlatButton(
  BuildContext context,
  String text,
  Function onPressedFunc,
) =>
    FlatButton(
      child: Text(text),
      onPressed: () async {
        await onPressedFunc();
        Navigator.pop(context);
      },
    );
