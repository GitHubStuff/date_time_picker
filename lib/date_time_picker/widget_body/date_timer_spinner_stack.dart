import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/widget_body/scroll_wheel_for_date.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/widget_body/scroll_wheel_for_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDateTimeStack extends StatelessWidget {
  final bool useSeconds;
  const ShowDateTimeStack({super.key, required this.useSeconds});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        final showDate = state.showDate;
        return Stack(
          children: [
            if (context.read<DateTimeCubit>().displayDate)
              IgnorePointer(
                ignoring: !showDate,
                child: AnimatedOpacity(
                  opacity: showDate ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child:
                      const ScrollWheelForDate(size: PickerStyling.spinnerSize),
                ),
              ),
            if (context.read<DateTimeCubit>().displayTime)
              IgnorePointer(
                ignoring: showDate,
                child: AnimatedOpacity(
                  opacity: showDate ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: ScrollWheelForTime(
                    size: PickerStyling.spinnerSize,
                    useSeconds: useSeconds,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
