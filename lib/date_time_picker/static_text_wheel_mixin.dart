import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/random_date_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin StaticTextWheelMixin<T extends StatefulWidget> on State<T> {
  Widget staticTextWheel({required double extent, required Widget content}) {
    return SizedBox(
      width: 8.0,
      height: extent,
      child: ListWheelScrollView(
        physics: const NeverScrollableScrollPhysics(),
        useMagnifier: true,
        itemExtent: extent,
        diameterRatio: 1.5,
        children: [content],
      ),
    );
  }

  Widget button(BuildContext context) => Padding(
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
