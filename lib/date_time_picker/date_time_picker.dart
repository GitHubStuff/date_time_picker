import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_time_header.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_time_selector_tab.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_timer_spinner_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'picker_styles.dart';

class DateTimePicker extends StatelessWidget {
  final Widget setDateTimeWidget;
  final String dateTimeFormat;
  final Widget? timeCaption;
  final Widget? dateCaption;

  const DateTimePicker({
    super.key,
    required this.setDateTimeWidget,
    required this.dateTimeFormat,
    this.dateCaption,
    this.timeCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: BlocProvider(
        create: (context) => DateTimeCubit(),
        child: Column(
          children: [
            DateTimeHeader(
              dateTimeFormat: dateTimeFormat,
              size: PickerStyles.headerSize,
              setWidget: setDateTimeWidget,
            ),
            DateTimeSelectorTabs(
              size: PickerStyles.selectorSize,
              dateCaption: dateCaption ?? const SizedBox.shrink(),
              timeCaption: timeCaption ?? const SizedBox.shrink(),
            ),
            const ShowDateTimeStack(),
          ],
        ),
      ),
    );
  }
}
