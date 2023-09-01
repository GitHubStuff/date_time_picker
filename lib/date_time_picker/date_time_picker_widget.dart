import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_time_header.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_time_selector_tab.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_timer_spinner_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'picker_styles.dart';

class DateTimePickerWidget extends StatelessWidget {
  final Widget setDateTimeWidget;
  final String? dateTimeFormat;
  final Widget? timeCaption;
  final Widget? dateCaption;
  final DateTimeCubit dateTimeCubit;
  final bool useSeconds;

  const DateTimePickerWidget({
    super.key,
    required this.setDateTimeWidget,
    this.dateTimeFormat,
    required this.dateTimeCubit,
    required this.useSeconds,
    this.dateCaption,
    this.timeCaption,
  });

  @override
  Widget build(BuildContext context) {
    assert(dateCaption != null || timeCaption != null,
        'dateCaption and timeCaption cannot be null');
    String? dateFormat = dateTimeFormat;
    if (dateFormat == null && dateCaption != null) {
      dateFormat = PickerStyling.dateFormat;
    } else if (dateFormat == null && timeCaption != null) {
      dateFormat = PickerStyling.timeFormat;
    }
    dateFormat ??= PickerStyling.dateTimeFormat;
    return Material(
      type: MaterialType.transparency,
      child: BlocProvider(
        create: (context) => dateTimeCubit,
        child: Column(
          children: [
            /// Displays the header with the date/time and the set button
            DateTimeHeader(
              dateTimeFormat: dateFormat,
              size: PickerStyling.headerSize,
              setWidget: setDateTimeWidget,
            ),

            /// Displays the date and time selector tabs with captions for each
            DateTimeSelectorTabs(
              size: PickerStyling.selectorSize,
              dateCaption: dateCaption ?? const SizedBox.shrink(),
              timeCaption: timeCaption ?? const SizedBox.shrink(),
            ),

            /// Displays the date and time spinners
            ShowDateTimeStack(useSeconds: useSeconds),
          ],
        ),
      ),
    );
  }
}
