import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeSelectorTabs extends StatelessWidget {
  final Size size;
  final Widget dateCaption;
  final Widget timeCaption;

  const DateTimeSelectorTabs({
    super.key,
    required this.size,
    required this.dateCaption,
    required this.timeCaption,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DateTimeCubit>();
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        children: [
          if (cubit.displayDate)
            Expanded(
              child: InkWell(
                onTap: () => cubit.showPicker(date: true),
                child: Container(
                  color: PickerStyles().dateColor,
                  child: Center(child: dateCaption),
                ),
              ),
            ),
          if (cubit.displayTime)
            Expanded(
              child: InkWell(
                onTap: () => cubit.showPicker(date: false),
                child: Container(
                  color: PickerStyles().timeColor,
                  child: Center(child: timeCaption),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
