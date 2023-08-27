import 'package:date_time_picker/date_time_picker/cubit/date_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'date_time_picker.dart';

const double _scaler = 3.4;
const TextStyle _textStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

class DateWheelSelector extends StatefulWidget {
  final Size size;

  const DateWheelSelector({super.key, this.size = const Size(220, 150)});

  @override
  State<DateWheelSelector> createState() => _DateWheelSelector();
}

class _DateWheelSelector extends State<DateWheelSelector> {
  final yearController = FixedExtentScrollController();
  final monthController = FixedExtentScrollController();
  final dayController = FixedExtentScrollController();

  late double _extent;
  late double _offset;

  @override
  void initState() {
    super.initState();
    _extent = widget.size.height / 5.0;
    _offset = -(0.56 * _extent - 12.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateCubit, DateState>(
      builder: (context, state) {
        if (state.jumpToDate) {
          yearController.jumpToItem(state.dateTime.year - 1900);
          monthController.jumpToItem(state.dateTime.month - 1);
          dayController.jumpToItem(state.dateTime.day - 1);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.purple[50],
                  height: widget.size.height,
                  width: widget.size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildYearWheel(context, state.dateTime.year),
                      _seperator('-'),
                      _buildMonthWheel(context, state.dateTime.month),
                      _seperator('-'),
                      _buildDayWheel(
                        context,
                        state: state,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.green[100],
                child: GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Jump to Random Date'),
                  ),
                  onTap: () {
                    context.read<DateCubit>().jumpTo(generateRandomDateTime());
                  },
                ),
              ),
            ),
          ],
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

  Widget _seperator(String text) {
    return Transform.translate(
      offset: Offset(0, _offset),
      child: SizedBox(
        height: widget.size.height,
        width: 8.0,
        child: const Center(child: Text('-', style: _textStyle)),
      ),
    );
  }

  Widget _buildYearWheel(BuildContext context, int selectedYear) {
    return SizedBox(
      width: widget.size.width / _scaler,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: yearController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (yearIndex) {
          context.read<DateCubit>().updateYear(1900 + yearIndex);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
            301, (index) => Text('${1900 + index}', style: _textStyle)),
      ),
    );
  }

  Widget _buildMonthWheel(BuildContext context, int selectedMonth) {
    List<String> months = List.generate(12, (index) {
      return DateFormat('MMM').format(DateTime(2021, index + 1));
    });
    return SizedBox(
      width: widget.size.width / _scaler,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: monthController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (monthIndex) {
          context.read<DateCubit>().updateMonth(monthIndex);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children:
            months.map((month) => Text(month, style: _textStyle)).toList(),
      ),
    );
  }

  Widget _buildDayWheel(BuildContext context, {required DateState state}) {
    return SizedBox(
      width: widget.size.width / _scaler,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: dayController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (day) {
          context.read<DateCubit>().updateDay(day + 1);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
          state.daysInMonth,
          (index) => Text('${index + 1}', style: _textStyle),
        ),
      ),
    );
  }
}
