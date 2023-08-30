import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:flutter/material.dart';

enum Sides {
  bottom,
  centerBottom,
  centerTop,
  left,
  right,
  top,
}

const _space = 4.0;

class PositionedDateTimeModal extends StatefulWidget {
  final Color barrierColor;
  final double? overrideXPos;
  final double? overrideYPos;
  final List<Sides> sidePriority;
  final Size pickerSize;
  final String dateTimeFormat;
  final Widget child;
  final Widget? dateCaption;
  final Widget setWidget;
  final Widget? timeCaption;
  final DateTimeCubit dateTimeCubit;

  const PositionedDateTimeModal({
    super.key,
    required this.child,
    this.dateCaption,
    required this.pickerSize,
    required this.setWidget,
    required this.dateTimeCubit,
    this.timeCaption,
    this.barrierColor = const Color(0x1f000000),
    this.dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a',
    this.overrideXPos,
    this.overrideYPos,
    this.sidePriority = const [
      Sides.right,
      Sides.left,
      Sides.centerTop,
      Sides.centerBottom,
      Sides.top,
      Sides.bottom,
    ],
  });

  @override
  State<PositionedDateTimeModal> createState() => _SideModal();
}

class _SideModal extends State<PositionedDateTimeModal> {
  final GlobalKey _key = GlobalKey();

  void _showPicker(Size pickerSize) {
    if (widget.overrideXPos != null && widget.overrideYPos != null) {
      showDateTimePickerModal(
        context,
        dateTimeCubit: widget.dateTimeCubit,
        barrierColor: widget.barrierColor,
        dateTimeFormat: widget.dateTimeFormat,
        setWidget: widget.setWidget,
        left: widget.overrideXPos!,
        top: widget.overrideYPos!,
        dateCaption: widget.dateCaption,
        timeCaption: widget.timeCaption,
      );
      return;
    }

    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double x;
    double y;

    bool foundFit = false;
    for (Sides side in widget.sidePriority) {
      switch (side) {
        case Sides.centerTop:
          x = widget.overrideXPos ??
              position.dx + renderBox.size.width / 2 - pickerSize.width / 2;
          y = widget.overrideYPos ?? position.dy - (pickerSize.height + _space);
          foundFit = (y >= 0 && x >= 0 && x + pickerSize.width <= screenWidth);
          break;
        case Sides.centerBottom:
          x = widget.overrideXPos ??
              position.dx + renderBox.size.width / 2 - pickerSize.width / 2;
          y = widget.overrideYPos ??
              position.dy + (renderBox.size.height + _space);
          foundFit = (y + pickerSize.height <= screenHeight &&
              x >= 0 &&
              x + pickerSize.width <= screenWidth);
          break;
        case Sides.top:
          x = widget.overrideXPos ?? position.dx;
          y = widget.overrideYPos ?? position.dy - (pickerSize.height + _space);
          foundFit = (y >= 0);
          break;
        case Sides.bottom:
          x = widget.overrideXPos ?? position.dx;
          y = widget.overrideYPos ??
              position.dy + (renderBox.size.height + _space);
          foundFit = (y + pickerSize.height <= screenHeight);
          break;
        case Sides.left:
          x = widget.overrideXPos ?? position.dx - (pickerSize.width + _space);
          y = widget.overrideYPos ??
              position.dy +
                  (renderBox.size.height / 2) -
                  (pickerSize.height * 0.70);
          foundFit = (x >= 0);
          break;
        case Sides.right:
          x = widget.overrideXPos ??
              position.dx + (renderBox.size.width + _space);
          y = widget.overrideYPos ??
              position.dy +
                  (renderBox.size.height / 2) -
                  (pickerSize.height * 0.70);
          foundFit = (x + pickerSize.width <= screenWidth);
          break;
      }
      if (foundFit) {
        showDateTimePickerModal(
          context,
          dateTimeCubit: widget.dateTimeCubit,
          barrierColor: widget.barrierColor,
          dateTimeFormat: widget.dateTimeFormat,
          setWidget: widget.setWidget,
          left: x,
          top: y,
          dateCaption: widget.dateCaption,
          timeCaption: widget.timeCaption,
        );
        return;
      }
    }
    if (!foundFit) {
      showDateTimePickerModal(
        context,
        dateTimeCubit: widget.dateTimeCubit,
        barrierColor: widget.barrierColor,
        setWidget: widget.setWidget,
        dateTimeFormat: widget.dateTimeFormat,
        left: (screenWidth - pickerSize.width) / 2,
        top: (screenHeight - pickerSize.height) / 2,
        dateCaption: widget.dateCaption,
        timeCaption: widget.timeCaption,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () => _showPicker(widget.pickerSize),
      child: widget.child,
    );
  }
}
