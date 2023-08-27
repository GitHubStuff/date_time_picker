import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/static_text_wheel_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeWheelSelector extends StatefulWidget {
  final bool useSeconds;
  final Size size;

  const TimeWheelSelector({
    super.key,
    this.useSeconds = false,
    this.size = const Size(220, 150),
  });

  @override
  State<TimeWheelSelector> createState() => _TimeWheelSelector();
}

class _TimeWheelSelector extends State<TimeWheelSelector>
    with StaticTextWheelMixin {
  final hourController = FixedExtentScrollController();
  final minuteController = FixedExtentScrollController();
  final secondController = FixedExtentScrollController();
  final medianController = FixedExtentScrollController();

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
          hourController.jumpToItem(state.dateTime.hour % 12);
          minuteController.jumpToItem(state.dateTime.minute);
          secondController.jumpToItem(state.dateTime.second);
          medianController.jumpToItem(state.median.index);
        }

        return Container(
          color: Colors.blue[50],
          height: widget.size.height,
          width: widget.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHourWheel(context, state.dateTime.hour),
              staticTextWheel(
                  extent: _extent, content: Text(':', style: textStyle)),
              _buildMinuteWheel(context, state.dateTime.minute),
              if (widget.useSeconds) ...[
                staticTextWheel(
                    extent: _extent, content: Text(':', style: textStyle)),
                _buildSecondWheel(context, state.dateTime.second),
              ],
              _buildMedianWheel(context, state.median),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    medianController.dispose();
    super.dispose();
  }

  Widget _buildHourWheel(BuildContext context, int selectedHour) {
    int displayHour = (selectedHour % 12 == 0) ? 12 : selectedHour % 12;

    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: hourController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (hour) {
          int adjustedHour =
              (selectedHour > 11 && hour != 11) ? hour + 12 : hour;
          context.read<DateTimeCubit>().updateHour(adjustedHour);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
          12,
          (index) => Text(
              '${(displayHour + index) % 12 == 0 ? 12 : (displayHour + index) % 12}',
              style: textStyle),
        ),
      ),
    );
  }

  Widget _buildMinuteWheel(BuildContext context, int selectedMinute) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: minuteController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (minute) {
          context.read<DateTimeCubit>().updateMinute(minute);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
            60,
            (index) =>
                Text(index.toString().padLeft(2, '0'), style: textStyle)),
      ),
    );
  }

  Widget _buildSecondWheel(BuildContext context, int selectedSecond) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: secondController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (second) {
          context.read<DateTimeCubit>().updateSecond(second);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
            60,
            (index) =>
                Text(index.toString().padLeft(2, '0'), style: textStyle)),
      ),
    );
  }

  Widget _buildMedianWheel(BuildContext context, Median median) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: medianController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          context.read<DateTimeCubit>().updateMedian(Median.values[index]);
        },
        diameterRatio: 1.5,
        magnification: 1.2,
        useMagnifier: true,
        itemExtent: _extent,
        children: Median.values
            .map((value) =>
                Text(value == Median.AM ? 'AM' : 'PM', style: textStyle))
            .toList(),
      ),
    );
  }
}
