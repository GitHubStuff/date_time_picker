import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:flutter/material.dart';

class PositionModal extends StatefulWidget {
  final Widget child;
  final Widget dateCaption;
  final Widget timeCaption;

  const PositionModal({
    Key? key,
    required this.child,
    required this.dateCaption,
    required this.timeCaption,
  }) : super(key: key);

  @override
  State<PositionModal> createState() => _PositionModal();
}

class _PositionModal extends State<PositionModal> {
  final GlobalKey _key = GlobalKey();

  void _showPicker() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final x = position.dx;
    final y = position.dy + renderBox.size.height;

    showDateTimePickerModal(
      context,
      left: x,
      top: y,
      dateCaption: widget.dateCaption,
      timeCaption: widget.timeCaption,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () => _showPicker(),
      child: widget.child,
    );
  }
}
