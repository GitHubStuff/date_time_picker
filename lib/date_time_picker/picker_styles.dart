import 'package:flutter/material.dart';

enum PickerMode { dark, light }

class PickerStyling {
  static const Color barrierColor = Color(0x1f000000);
  static const Color darkDateColor = Color(0xff003366);
  static const Color darkTimeColor = Color(0xff4b0082);
  static const Color darkTitleColor = Color(0xff002855);
  static const Color liteDateColor = Color(0xFFFFFFFF);
  static const Color liteTimeColor = Color(0xFFE0E0E0);
  static const Color liteTitleColor = Color(0xFFF5F5F5);
  static const double diameterRatio = 1.5;
  static const double magnification = 1.2;
  static const double width = 250.0;
  static const Size headerSize = Size(width, 56.0);
  static const Size pickerSize = Size(width, 255.0);
  static const Size selectorSize = Size(width, 49.0);
  static const Size spinnerSize = Size(width, 150.0);
  static const String dateFormat = 'EEE MMM d, y';
  static const String dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a';
  static const String timeFormat = 'h:mm a';
  static const String timeFormatWithSeconds = 'h:mm:ss a';
  static const TextStyle darkHeaderStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xffff4500));
  static const TextStyle darkTextStyle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xffff4500));
  static const TextStyle liteHeaderStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xff000000));
  static const TextStyle liteTextStyle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xff000000));

  // Singleton boilerplate
  static final PickerStyling _instance = PickerStyling._internal();

  PickerStyling._internal();

  factory PickerStyling.init({
    Color? titleColorDark,
    Color? titleColorLight,
    Color? dateColorDark,
    Color? dateColorLight,
    Color? timeColorDark,
    Color? timeColorLight,
    TextStyle? titleStyleDark,
    TextStyle? titleStyleLight,
    TextStyle? dateStyleDark,
    TextStyle? dateStyleLight,
  }) {
    /// Dark Mode
    _instance._dateColorDark = dateColorDark ?? darkDateColor;
    _instance._timeColorDark = timeColorDark ?? darkTimeColor;
    _instance._titleColorDark = titleColorDark ?? darkTitleColor;
    _instance._dateStyleDark = dateStyleDark ??
        const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        );
    _instance._titleStyleDark = titleStyleDark ??
        const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        );

    /// Light Mode
    _instance._dateColorLight = dateColorLight ?? liteDateColor;
    _instance._timeColorLight = timeColorLight ?? liteTimeColor;
    _instance._titleColorLight = titleColorLight ?? liteTitleColor;
    _instance._dateStyleLight = dateStyleLight ??
        const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Color(0xff000000),
        );
    _instance._titleStyleLight = titleStyleLight ??
        const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Color(0xff000000),
        );

    return _instance;
  }

  factory PickerStyling() {
    return _instance;
  }

  // Properties with default values
  late final Color _titleColorDark;
  late final Color _titleColorLight;
  late final Color _dateColorDark;
  late final Color _dateColorLight;
  late final Color _timeColorDark;
  late final Color _timeColorLight;
  late final TextStyle _titleStyleDark;
  late final TextStyle _titleStyleLight;
  late final TextStyle _dateStyleDark;
  late final TextStyle _dateStyleLight;

  // Getters
  Color titleColor(PickerMode mode) =>
      mode == PickerMode.dark ? _titleColorDark : _titleColorLight;
  Color dateColor(PickerMode mode) =>
      mode == PickerMode.dark ? _dateColorDark : _dateColorLight;
  Color timeColor(PickerMode mode) =>
      mode == PickerMode.dark ? _timeColorDark : _timeColorLight;
  TextStyle titleStyle(PickerMode mode) =>
      mode == PickerMode.dark ? _titleStyleDark : _titleStyleLight;
  TextStyle textStyle(PickerMode mode) =>
      mode == PickerMode.dark ? _dateStyleDark : _dateStyleLight;
}
