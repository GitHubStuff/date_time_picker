import 'package:flutter/material.dart';

class PickerStyles {
  // Singleton boilerplate
  static final PickerStyles _instance = PickerStyles._internal();

  PickerStyles._internal();

  factory PickerStyles.init({
    Color? dateColor,
    Color? timeColor,
    Color? headerColor,
    TextStyle? textStyle,
    TextStyle? headerStyle,
  }) {
    _instance.dateColor = dateColor ?? Colors.purple[100]!;
    _instance.timeColor = timeColor ?? Colors.green[100]!;
    _instance.headerColor = headerColor ?? Colors.blue[100]!;
    _instance.textStyle = textStyle ??
        const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
    _instance.headerStyle = headerStyle ??
        const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);
    return _instance;
  }

  factory PickerStyles() {
    return _instance;
  }

  // Properties with default values
  late Color dateColor;
  late Color timeColor;
  late Color headerColor;
  late TextStyle textStyle;
  late TextStyle headerStyle;
}
