import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
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
            child: Text('Jump to Random Date'),
          ),
          onTap: () {
            context.read<DateTimeCubit>().jumpTo(generateRandomDateTime());
          },
        ),
      ),
    );
  }
}
