import 'dart:async';

import 'package:date_time_picker/date_time_picker/cubit/date_time_broadcast.dart';
import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
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
  final bool useSeconds;
  final Color barrierColor;
  final double? overrideXPos;
  final double? overrideYPos;
  final int? broadcastId;
  final List<Sides> sidePriority;
  final PickerMode pickerMode;
  final Size pickerSize;
  final StreamController<DateTimeBroadcast>? dateTimeBroadcast;
  final String? dateTimeFormat;
  final Widget child;
  final Widget setWidget;
  final Widget? dateCaption;
  final Widget? timeCaption;

  const PositionedDateTimeModal({
    super.key,
    required this.child,
    required this.pickerMode,
    required this.pickerSize,
    required this.setWidget,
    required this.useSeconds,
    this.barrierColor = PickerStyling.barrierColor,
    this.broadcastId,
    this.dateCaption,
    this.dateTimeBroadcast,
    this.dateTimeFormat,
    this.overrideXPos,
    this.overrideYPos,
    this.timeCaption,
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

  void _showPicker(Size pickerSize) async {
    if (widget.overrideXPos != null && widget.overrideYPos != null) {
      final t = await showDateTimePickerModal(
        context,
        barrierColor: widget.barrierColor,
        broadcastId: widget.broadcastId,
        dateCaption: widget.dateCaption,
        dateTimeFormat: widget.dateTimeFormat,
        left: widget.overrideXPos!,
        messageController: widget.dateTimeBroadcast,
        pickerMode: widget.pickerMode,
        setWidget: widget.setWidget,
        size: widget.pickerSize,
        timeCaption: widget.timeCaption,
        top: widget.overrideYPos!,
        useSeconds: widget.useSeconds,
      );
      debugPrint('_showPicker t: $t');
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
        final k = await showDateTimePickerModal(
          context,
          barrierColor: widget.barrierColor,
          broadcastId: 12,
          dateCaption: widget.dateCaption,
          dateTimeFormat: widget.dateTimeFormat,
          left: x,
          messageController: widget.dateTimeBroadcast,
          pickerMode: widget.pickerMode,
          setWidget: widget.setWidget,
          timeCaption: widget.timeCaption,
          top: y,
          useSeconds: widget.useSeconds,
        );
        debugPrint('_showPicker k: $k');
        return;
      }
    }
    if (!foundFit) {
      final m = await showDateTimePickerModal(
        context,
        barrierColor: widget.barrierColor,
        broadcastId: 14,
        dateCaption: widget.dateCaption,
        dateTimeFormat: widget.dateTimeFormat,
        left: (screenWidth - pickerSize.width) / 2,
        messageController: widget.dateTimeBroadcast,
        pickerMode: widget.pickerMode,
        setWidget: widget.setWidget,
        timeCaption: widget.timeCaption,
        top: (screenHeight - pickerSize.height) / 2,
        useSeconds: widget.useSeconds,
      );
      debugPrint('_showPicker m: $m');
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
