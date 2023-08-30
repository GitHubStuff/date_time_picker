import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_time_header.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_time_selector_tab.dart';
import 'package:date_time_picker/date_time_picker/widget_body/date_timer_spinner_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'picker_styles.dart';

class DateTimePickerWidget extends StatelessWidget {
  final Widget setDateTimeWidget;
  final String dateTimeFormat;
  final Widget? timeCaption;
  final Widget? dateCaption;
  final DateTimeCubit dateTimeCubit;

  const DateTimePickerWidget({
    super.key,
    required this.setDateTimeWidget,
    required this.dateTimeFormat,
    required this.dateTimeCubit,
    this.dateCaption,
    this.timeCaption,
  });

  @override
  Widget build(BuildContext context) {
    assert(dateCaption != null || timeCaption != null,
        'dateCaption and timeCaption cannot be null');
    return Material(
      type: MaterialType.transparency,
      child: BlocProvider(
        create: (context) => dateTimeCubit,
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
