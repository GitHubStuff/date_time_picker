import 'dart:async';

import 'package:date_time_picker/date_time_picker/cubit/date_time_broadcast.dart';
import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/date_time_picker_widget.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePickerModal(
  BuildContext context, {
  double? left,
  double? top,
  Object? broadcastId,
  required bool useSeconds,
  required Color barrierColor,
  required PickerMode pickerMode,
  required Widget setWidget,
  Size size = PickerStyling.pickerSize,
  StreamController<DateTimeBroadcast>? messageController,
  String? dateTimeFormat,
  Widget? dateCaption,
  Widget? timeCaption,
}) async {
  DateTime? result = await showGeneralDialog(
    context: context,
    barrierLabel: "Modal",
    barrierDismissible: true,
    barrierColor: barrierColor,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => DateTimePickerModalContent(
      barrierColor: barrierColor,
      useSeconds: useSeconds,
      dateTimeCubit: DateTimeCubit(
        broadcastId: broadcastId,
        dateTimeType: DateTimeType.getType(
            dateWidget: dateCaption,
            timeWidget: timeCaption,
            showSeconds: useSeconds),
        pickerMode: pickerMode,
      ),
      dateTimeFormat: dateTimeFormat,
      setWidget: setWidget,
      dateCaption: dateCaption,
      timeCaption: timeCaption,
      top: top,
      left: left,
      size: size,
    ),
  );
  return result;
}

class DateTimePickerModalContent extends StatelessWidget {
  final double? top;
  final double? left;
  final Size size;
  final Color barrierColor;
  final String? dateTimeFormat;
  final Widget setWidget;
  final Widget? dateCaption;
  final Widget? timeCaption;
  final DateTimeCubit dateTimeCubit;
  final bool useSeconds;

  const DateTimePickerModalContent(
      {super.key,
      required this.size,
      required this.barrierColor,
      this.dateTimeFormat,
      required this.setWidget,
      required this.dateTimeCubit,
      this.dateCaption,
      this.timeCaption,
      this.top,
      this.left,
      required this.useSeconds});

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
          onTap: () => Navigator.of(context).pop(null),
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
              child: DateTimePickerWidget(
                dateTimeCubit: dateTimeCubit,
                dateCaption: dateCaption,
                timeCaption: timeCaption,
                setDateTimeWidget: setWidget,
                dateTimeFormat: dateTimeFormat,
                useSeconds: useSeconds,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
