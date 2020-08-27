import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelTextFormField extends StatelessWidget {
  final double formHeight;
  final bool editStatus;
  final String labelText;
  final TextStyle labelTextStyle;
  final TextStyle fieldTextStyle;
  final TextEditingController controller;
  final int maxLength;
  final Decoration fieldDecoration;
  final IconData icon;
  final String iconText;
  final String hintText;
  final TextStyle hintStyle;
  final Color themeColor;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;
  final String Function(String) validationMixin;
  final Function saveMixin;

  LabelTextFormField({
    this.formHeight,
    this.editStatus,
    this.labelText,
    this.labelTextStyle,
    this.fieldTextStyle,
    this.controller,
    this.maxLength,
    this.fieldDecoration,
    this.icon,
    this.iconText,
    this.hintText,
    this.hintStyle,
    this.themeColor,
    this.inputType = TextInputType.text,
    this.inputFormatters,
    this.validationMixin,
    this.saveMixin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //* label text
        Text(labelText, style: labelTextStyle),

        SizedBox(height: 10.0),

        Container(
          alignment: Alignment.centerLeft,
          decoration: fieldDecoration,
          height: formHeight,

          //* text form field
          child: TextFormField(
            enabled: editStatus ? true : false,
            controller: controller,
            maxLength: editStatus ? maxLength : null,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            autovalidate: true,
            validator: (value) => validationMixin(value),
            onSaved: saveMixin,
            style: fieldTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15.0),
                prefixIcon: CircleAvatar(
                  child: icon == null
                      ? Text(
                          iconText[0].toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      : Icon(icon),
                  backgroundColor: Colors.transparent,
                  foregroundColor: themeColor,
                ),
                hintText: hintText,
                hintStyle: hintStyle),
          ),
        ),
      ],
    );
  }
}
