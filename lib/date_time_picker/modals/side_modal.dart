import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:flutter/material.dart';

enum Side { top, bottom, left, right }

const _space = 4.0;

class SideModal extends StatefulWidget {
  final Size pickerSize;
  final Widget child;
  final List<Side> sidePriority;
  final Widget dateCaption;
  final Widget timeCaption;

  const SideModal(
      {Key? key,
      required this.child,
      required this.pickerSize,
      required this.dateCaption,
      required this.timeCaption,
      this.sidePriority = const [
        Side.right,
        Side.left,
        Side.top,
        Side.bottom,
      ]})
      : super(key: key);

  @override
  State<SideModal> createState() => _SideModal();
}

class _SideModal extends State<SideModal> {
  final GlobalKey _key = GlobalKey();

  void _showPicker(Size pickerSize) {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double x = (screenWidth - pickerSize.width) / 2;
    double y = (screenHeight - pickerSize.height) / 2;

    bool foundFit = false;
    for (Side side in widget.sidePriority) {
      switch (side) {
        case Side.top:
          x = position.dx;
          y = position.dy - (pickerSize.height + _space);
          foundFit = (y >= 0);
          break;
        case Side.bottom:
          x = position.dx;
          y = position.dy + (renderBox.size.height + _space);
          foundFit = (y + pickerSize.height <= screenHeight);
          break;
        case Side.left:
          x = position.dx - (pickerSize.width + _space);
          y = position.dy +
              (renderBox.size.height / 2) -
              (pickerSize.height * 0.70);
          foundFit = (x >= 0);
          break;
        case Side.right:
          x = position.dx + (renderBox.size.width + _space);
          y = position.dy +
              (renderBox.size.height / 2) -
              (pickerSize.height * 0.70);
          foundFit = (x + pickerSize.width <= screenWidth);
          break;
      }
      if (foundFit) {
        showDateTimePickerModal(
          context,
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
        left: x,
        top: y,
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
