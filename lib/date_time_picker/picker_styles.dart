import 'package:flutter/material.dart';

class PickerStyles {
  static const Size pickerSize = Size(230.0, 255.0);
  static const Size headerSize = Size(230.0, 56.0);
  static const Size selectorSize = Size(230.0, 49.0);
  static const Size spinnerSize = Size(230.0, 150.0);
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
