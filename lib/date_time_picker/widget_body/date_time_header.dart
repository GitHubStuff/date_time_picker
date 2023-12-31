import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateTimeHeader extends StatelessWidget {
  final String dateTimeFormat;
  final Widget setWidget;
  final Size size;

  const DateTimeHeader({
    super.key,
    required this.dateTimeFormat,
    required this.setWidget,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        final formattedDate = DateFormat(dateTimeFormat).format(state.dateTime);
        return Container(
          color: PickerStyling().titleColor(state.pickerMode),
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 12.0,
                  right: size.height * 0.721,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formattedDate,
                    style: PickerStyling().titleStyle(state.pickerMode),
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<DateTimeCubit>().setDateTime(true);
                      DateTime result =
                          context.read<DateTimeCubit>().state.dateTime;
                      Navigator.of(context).pop<DateTime>(result);
                    },
                    child: setWidget,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
