import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/date_time_header.dart';
import 'package:date_time_picker/date_time_picker/date_time_toggle.dart';
import 'package:date_time_picker/date_time_picker/date_wheel_selector.dart';
import 'package:date_time_picker/date_time_picker/time_wheel_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'picker_styles.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    PickerStyles.init();
    return BlocProvider(
      create: (context) => DateTimeCubit(),
      child: const Column(
        children: [
          DateTimeHeader(
            setWidget: Text('🟢'),
          ),
          DateTimeToggle(),
          ShowDateTimeStack(),
        ],
      ),
    );
  }
}

class ShowDateTimeStack extends StatelessWidget {
  const ShowDateTimeStack({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        final showDate = state.showDate;
        debugPrint('showDate = $showDate');
        return Stack(
          children: [
            IgnorePointer(
              ignoring: !showDate,
              child: AnimatedOpacity(
                  opacity: showDate ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const DateWheelSelector()),
            ),
            IgnorePointer(
              ignoring: showDate,
              child: AnimatedOpacity(
                  opacity: showDate ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: const TimeWheelSelector()),
            ),
          ],
        );
      },
    );
  }
}
