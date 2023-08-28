import 'package:date_time_picker/date_time_picker/show_date_timer_picker_modal.dart';
import 'package:flutter/material.dart';

class PositionModal extends StatefulWidget {
  final Widget child;

  const PositionModal({Key? key, required this.child}) : super(key: key);

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
    final y = position.dy +
        renderBox.size.height; // y coordinate just below the widget

    showDateTimePickerModal(context, left: x, top: y);
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
