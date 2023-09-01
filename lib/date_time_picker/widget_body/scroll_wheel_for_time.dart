import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/widget_body/static_text_wheel_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollWheelForTime extends StatefulWidget {
  final bool useSeconds;
  final Size size;

  const ScrollWheelForTime({
    super.key,
    this.useSeconds = false,
    required this.size,
  });

  @override
  State<ScrollWheelForTime> createState() => _TimeWheelSelector();
}

class _TimeWheelSelector extends State<ScrollWheelForTime>
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
          Future.delayed(Duration.zero, () {
            hourController.jumpToItem(state.dateTime.hour % 12 + 12);
            minuteController.jumpToItem(state.dateTime.minute + 60);
            secondController.jumpToItem(state.dateTime.second + 60);
            medianController.jumpToItem(state.median.index);
          });
        }

        return Container(
          color: PickerStyling().timeColor(state.pickerMode),
          height: widget.size.height,
          width: widget.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHourWheel(context, state.dateTime.hour, state.pickerMode),
              staticTextWheel(
                  extent: _extent,
                  content: Text(':',
                      style: PickerStyling().textStyle(state.pickerMode))),
              _buildMinuteWheel(context, state.dateTime.minute, state.pickerMode),
              if (widget.useSeconds) ...[
                staticTextWheel(
                    extent: _extent,
                    content: Text(':',
                        style: PickerStyling().textStyle(state.pickerMode))),
                _buildSecondWheel(context, state.dateTime.second, state.pickerMode),
              ],
              _buildMedianWheel(context, state.median, state.pickerMode),
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

  Widget _buildHourWheel(
      BuildContext context, int selectedHour, PickerMode mode) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: hourController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (hour) {
          context.read<DateTimeCubit>().updateHour(hour % 12);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
          36,
          (index) => Text(
            '${(index) % 12 == 0 ? 12 : (index) % 12}',
            style: PickerStyling().textStyle(mode),
          ),
        ),
      ),
    );
  }

  Widget _buildMinuteWheel(
      BuildContext context, int selectedMinute, PickerMode mode) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: minuteController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (minute) {
          context.read<DateTimeCubit>().updateMinute(minute % 60);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
          180,
          (index) => Text((index % 60).toString().padLeft(2, '0'),
              style: PickerStyling().textStyle(mode)),
        ),
      ),
    );
  }

  Widget _buildSecondWheel(
      BuildContext context, int selectedSecond, PickerMode mode) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: secondController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (second) {
          context.read<DateTimeCubit>().updateSecond(second);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: List.generate(
            180,
            (index) => Text((index % 60).toString().padLeft(2, '0'),
                style: PickerStyling().textStyle(mode))),
      ),
    );
  }

  Widget _buildMedianWheel(
      BuildContext context, Median median, PickerMode mode) {
    return SizedBox(
      width: widget.size.width / 4.0,
      height: widget.size.height,
      child: ListWheelScrollView(
        controller: medianController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          context.read<DateTimeCubit>().updateMedian(Median.values[index]);
        },
        diameterRatio: PickerStyling.diameterRatio,
        magnification: PickerStyling.magnification,
        useMagnifier: true,
        itemExtent: _extent,
        children: Median.values
            .map((value) => Text(value == Median.AM ? 'AM' : 'PM',
                style: PickerStyling().textStyle(mode)))
            .toList(),
      ),
    );
  }
}
