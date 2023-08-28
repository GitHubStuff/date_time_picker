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
    this.dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a', // Default format
    required this.setWidget,
    this.size = const Size(230.0, 56.0),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        final formattedDate = DateFormat(dateTimeFormat).format(state.dateTime);
        return Container(
          color: PickerStyles().headerColor,
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
                    style: PickerStyles().headerStyle,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SizedBox(
                    width: size.height * 0.721,
                    height: size.height * 0.721,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: setWidget,
                    ),
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
