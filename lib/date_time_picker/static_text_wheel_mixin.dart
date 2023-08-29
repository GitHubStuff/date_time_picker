import 'package:date_time_picker/date_time_picker/picker_styles.dart';
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
        diameterRatio: PickerStyles.diameterRatio,
        children: [content],
      ),
    );
  }
}
