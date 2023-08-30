import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/widget_body/scroll_wheel_for_date.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/widget_body/scroll_wheel_for_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDateTimeStack extends StatelessWidget {
  const ShowDateTimeStack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        final showDate =
            state.showDate && context.read<DateTimeCubit>().displayDate;
        final showTime =
            !state.showDate && context.read<DateTimeCubit>().displayTime;
        return Stack(
          children: [
            if (context.read<DateTimeCubit>().displayDate)
              IgnorePointer(
                ignoring: !showDate,
                child: AnimatedOpacity(
                  opacity: showDate ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child:
                      const ScrollWheelForDate(size: PickerStyles.spinnerSize),
                ),
              ),
            if (context.read<DateTimeCubit>().displayTime)
              IgnorePointer(
                ignoring: !showTime,
                child: AnimatedOpacity(
                    opacity: showDate ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: const ScrollWheelForDate(
                        size: PickerStyles.spinnerSize)),
              ),
            IgnorePointer(
              ignoring: showDate,
              child: AnimatedOpacity(
                  opacity: showDate ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child:
                      const ScrollWheelForTime(size: PickerStyles.spinnerSize)),
            ),
          ],
        );
      },
    );
  }
}
