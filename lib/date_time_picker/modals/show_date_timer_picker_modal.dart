import 'package:date_time_picker/date_time_picker/date_time_picker.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/aqua_button.dart';
import 'package:flutter/material.dart';

Future<void> showDateTimePickerModal(
  BuildContext context, {
  double? top,
  double? left,
  Size size = PickerStyles.pickerSize,
  Color barrierColor = const Color(0x0f000000),
  String dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a',
  Widget? setWidget,
  required Widget dateCaption,
  required Widget timeCaption,
}) async {
  await showGeneralDialog(
    context: context,
    barrierLabel: "Modal",
    barrierDismissible: true,
    barrierColor: barrierColor,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => DateTimePickerModalContent(
      barrierColor: barrierColor,
      dateTimeFormat: dateTimeFormat,
      dismissWidget: setWidget ?? const AquaButton(),
      dateCaption: dateCaption,
      timeCaption: timeCaption,
      top: top,
      left: left,
      size: size,
    ),
  );
}

class DateTimePickerModalContent extends StatelessWidget {
  final double? top;
  final double? left;
  final Size size;
  final Color barrierColor;
  final String dateTimeFormat;
  final Widget dismissWidget;
  final Widget dateCaption;
  final Widget timeCaption;

  const DateTimePickerModalContent({
    super.key,
    required this.size,
    required this.barrierColor,
    required this.dateTimeFormat,
    required this.dismissWidget,
    required this.dateCaption,
    required this.timeCaption,
    this.top,
    this.left,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate center position if top and left aren't provided
    final defaultTop = (screenHeight - size.height) / 2.0;
    final defaultLeft = (screenWidth - size.width) / 2.0;

    return Stack(
      children: [
        /// Makes the modal dismissable by tapping the barrier
        GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.translucent,
          child: Container(
            color: barrierColor,
          ),
        ),
        Positioned(
          top: top ?? defaultTop,
          left: left ?? defaultLeft,

          /// Make sure taps don't go through the modal
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.transparent,
              child: DateTimePicker(
                dateCaption: dateCaption,
                timeCaption: timeCaption,
                setDateTimeWidget: dismissWidget,
                dateTimeFormat: dateTimeFormat,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
