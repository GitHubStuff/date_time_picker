import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/widget_body/static_text_wheel_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

const double _scaler = 3.4;

class ScrollWheelForDate extends StatefulWidget {
  final Size size;

  const ScrollWheelForDate({
    super.key,
    required this.size,
  });

  @override
  State<ScrollWheelForDate> createState() => _DateWheelSelector();
}

class _DateWheelSelector extends State<ScrollWheelForDate>
    with StaticTextWheelMixin {
  final yearController = FixedExtentScrollController();
  final monthController = FixedExtentScrollController();
  final dayController = FixedExtentScrollController();

  late double _extent;

  @override
  void initState() {
    super.initState();
    _extent = widget.size.height / 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      builder: (context, state) {
        if (state.jumpToDateTime) {
          Future.delayed(Duration.zero, () {
            yearController.jumpToItem(state.dateTime.year - 1900);
            monthController.jumpToItem(state.dateTime.month - 1 + 12);
            final days = state.daysInMonth;
            dayController.jumpToItem(state.dateTime.day - 1 + days);
          });
        }
        return Container(
          color: (PickerStyling().dateColor(state.pickerMode)),
          height: widget.size.height,
          width: widget.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 4.0),
              _buildYearWheel(context, state.dateTime.year, state.pickerMode),
              staticTextWheel(
                  extent: _extent,
                  content: Text(
                    '-',
                    style: PickerStyling().textStyle(state.pickerMode),
                  )),
              _buildMonthWheel(context, state.dateTime.month, state.pickerMode),
              staticTextWheel(
                  extent: _extent,
                  content: Text(
                    '-',
                    style: PickerStyling().textStyle(state.pickerMode),
                  )),
              _buildDayWheel(
                context,
                state: state,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  Widget _buildYearWheel(
      BuildContext context, int selectedYear, PickerMode mode) {
    return SizedBox(
      width: widget.size.width / _scaler,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: yearController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (yearIndex) {
          context.read<DateTimeCubit>().updateYear(1900 + yearIndex);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
            301,
            (index) => Text('${1900 + index}',
                style: PickerStyling().textStyle(mode))),
      ),
    );
  }

  Widget _buildMonthWheel(
      BuildContext context, int selectedMonth, PickerMode mode) {
    List<String> months = List.generate(36, (index) {
      return DateFormat('MMM').format(DateTime(2021, (index % 12) + 1));
    });
    return SizedBox(
      width: widget.size.width / _scaler,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: monthController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (monthIndex) {
          context.read<DateTimeCubit>().updateMonth(monthIndex % 12);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: months
            .map((month) => Text(month, style: PickerStyling().textStyle(mode)))
            .toList(),
      ),
    );
  }

  Widget _buildDayWheel(BuildContext context, {required DateTimeState state}) {
    return SizedBox(
      width: widget.size.width / _scaler,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: dayController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (day) {
          context
              .read<DateTimeCubit>()
              .updateDay((day % state.daysInMonth) + 1);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
          state.daysInMonth * 3,
          (index) => Text('${(index % state.daysInMonth) + 1}',
              style: PickerStyling().textStyle(state.pickerMode)),
        ),
      ),
    );
  }
}
