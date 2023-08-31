import 'package:flutter/material.dart';

class PickerStyles {
  static const double diameterRatio = 1.5;
  static const double magnification = 1.2;
  static const Size pickerSize = Size(230.0, 255.0);
  static const Size headerSize = Size(230.0, 56.0);
  static const Size selectorSize = Size(230.0, 49.0);
  static const Size spinnerSize = Size(230.0, 150.0);
  static const String dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a';
  static const String dateFormat = 'EEE MMM d, y';
  static const String timeFormat = 'h:mm:ss a';
  static const Color barrierColor = Color(0x1f000000);

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
  late final Color dateColor;
  late final Color timeColor;
  late final Color headerColor;
  late final TextStyle textStyle;
  late final TextStyle headerStyle;
}
