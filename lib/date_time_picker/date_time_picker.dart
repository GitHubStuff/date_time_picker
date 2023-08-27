import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/date_wheel_selector.dart';
import 'package:date_time_picker/date_time_picker/random_date_button.dart';
import 'package:date_time_picker/date_time_picker/time_wheel_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateTimeCubit(),
      child: const Column(
        children: [
          DateWheelSelector(),
          TimeWheelSelector(),
          JumpToRandomDateButton(),
        ],
      ),
    );
  }
}
