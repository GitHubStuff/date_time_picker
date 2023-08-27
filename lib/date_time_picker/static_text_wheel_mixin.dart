import 'package:flutter/material.dart';

mixin StaticTextWheelMixin<T extends StatefulWidget> on State<T> {
  Widget staticTextWheel({required double extent, required Widget content}) {
    return SizedBox(
      width: 8.0,
      height: extent,
      child: ListWheelScrollView(
        physics: const NeverScrollableScrollPhysics(),
        useMagnifier: true,
        itemExtent: extent,
        diameterRatio: 1.5,
        children: [content],
      ),
    );
  }

  TextStyle get textStyle => const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      );
}
