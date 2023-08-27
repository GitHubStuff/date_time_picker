import 'dart:math';

import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/date_wheel_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

DateTime generateRandomDateTime() {
    final random = Random();
    final currentYear = DateTime.now().year;

    // Randomly decide if we add or subtract years (0: subtract, 1: add)
    final addOrSubtract = random.nextBool() ? 1 : -1;

    // Randomly choose a year between 0 and 5
    final yearDifference = random.nextInt(6) * addOrSubtract;

    final targetYear = currentYear + yearDifference;

    // Randomly choose a month between 1 and 12
    final month = random.nextInt(12) + 1;

    // Generate a date within that month. This logic ensures we don't try to generate,
    // for example, February 30.
    final day = random.nextInt(DateTime(targetYear, month + 1, 0).day) + 1;

    return DateTime(targetYear, month, day);
  }

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateTimeCubit(),
      child: const Column(
        children: [
          DateWheelSelector(),
        ],
      ),
    );
  }
}
