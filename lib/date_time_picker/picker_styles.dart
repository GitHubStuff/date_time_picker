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
    _instance.dateColor = dateColor ?? const Color(0xff003366);
    _instance.timeColor = timeColor ?? const Color(0xff4b0082);
    _instance.headerColor = headerColor ?? const Color(0xff002855);
    _instance.textStyle = textStyle ??
        const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Color(0xffff4500));
    _instance.headerStyle = headerStyle ??
        const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Color(0xffff4500));
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
