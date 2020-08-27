import 'package:flutter/material.dart';

class DropDownField<T> extends StatelessWidget {
  final String labelText;
  final TextStyle labelTextStyle;
  final Decoration fieldDecoration;
  final IconData icon;
  final String hintText;
  final TextStyle hintStyle;
  final Color themeColor;
  final T selectedValue;
  final List<T> items;
  final void Function(T) onChangedFunc;
  final DropdownMenuItem<T> Function(T) dropDownMenuItem;

  DropDownField({
    this.labelText,
    this.labelTextStyle,
    this.fieldDecoration,
    this.icon,
    this.hintText,
    this.hintStyle,
    this.themeColor,
    this.selectedValue,
    this.items,
    this.onChangedFunc,
    this.dropDownMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* drop down label
          Text(labelText, style: labelTextStyle),

          SizedBox(height: 10.0),

          //* drop down stack [(container -> padding, decoration, child -> drop down button) - (container -> text)]
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 47, right: 10),
                decoration: fieldDecoration,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                      itemHeight: 50,
                      icon: Icon(icon, color: themeColor),
                      isExpanded: true,
                      hint: Text(hintText, style: hintStyle),
                      value: selectedValue,
                      onChanged: (value) {
                        onChangedFunc(value);
                      },
                      items: items != null
                          ? items.map((item) {
                              return dropDownMenuItem(item);
                            }).toList()
                          : null),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, left: 2.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: themeColor,
                  child: Text(
                    labelText[0].toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          )
        ]);
  }
}
