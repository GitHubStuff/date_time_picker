import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeToggle extends StatelessWidget {
  final Size size;

  const DateTimeToggle({Key? key, this.size = const Size(230, 48)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<DateTimeCubit>().showPicker(date: true);
              },
              child: Container(
                color: PickerStyles().dateColor, // Unique color for Date
                child: Center(
                    child: Text("Date", style: PickerStyles().textStyle)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<DateTimeCubit>().showPicker(date: false);
              },
              child: Container(
                color: PickerStyles().timeColor, // Unique color for Time
                child: Center(
                    child: Text("Time", style: PickerStyles().textStyle)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
