import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelTextFormField extends StatelessWidget {
  final double formHeight;
  final bool editStatus;
  final bool obscureStatus;
  final bool autoValidateStatus;
  final bool readOnlyStatus;
  final String labelText;
  final TextStyle labelTextStyle;
  final TextStyle fieldTextStyle;
  final TextEditingController controller;
  final int maxLength;
  final Decoration fieldDecoration;
  final IconData icon;
  final IconData suffixIcon;
  final String iconText;
  final String hintText;
  final TextStyle hintStyle;
  final Color themeColor;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;
  final Future<void> Function() onTapFunc;
  final String Function(String) validationMixin;
  final Function saveMixin;

  LabelTextFormField({
    this.formHeight,
    this.editStatus = true,
    this.obscureStatus = false,
    this.autoValidateStatus = true,
    this.readOnlyStatus = false,
    this.labelText,
    this.labelTextStyle,
    this.fieldTextStyle,
    this.controller,
    this.maxLength,
    this.fieldDecoration,
    this.icon,
    this.suffixIcon,
    this.iconText,
    this.hintText,
    this.hintStyle,
    this.themeColor,
    this.inputType = TextInputType.text,
    this.inputFormatters,
    this.onTapFunc,
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
            readOnly: readOnlyStatus,
            obscureText: obscureStatus,
            controller: controller,
            maxLength: autoValidateStatus ? maxLength : null,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            autovalidate: autoValidateStatus ? true : false,
            onTap: () async => onTapFunc != null ? await onTapFunc() : null,
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
                suffixIcon: suffixIcon != null
                    ? Icon(
                        suffixIcon,
                        color: themeColor,
                      )
                    : null,
                hintText: hintText,
                hintStyle: hintStyle),
          ),
        ),
      ],
    );
  }
}
