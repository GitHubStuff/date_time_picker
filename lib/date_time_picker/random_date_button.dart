import 'dart:math';

import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
// ignore: unused_import
import 'package:date_time_picker/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JumpToRandomDateButton extends StatelessWidget {
  const JumpToRandomDateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.green[100],
        child: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Text('Jump to Random Date', style: TextStyle(fontSize: 28.0)),
          ),
          onTap: () {
            context.read<DateTimeCubit>().jumpTo(generateRandomDateTime());
          },
        ),
      ),
    );
  }
}

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

  final hour = random.nextInt(24);
  final minute = random.nextInt(60);
  final second = random.nextInt(60);

  return DateTime(targetYear, month, day, hour, minute, second);
}