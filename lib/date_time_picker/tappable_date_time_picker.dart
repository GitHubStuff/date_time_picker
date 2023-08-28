import 'package:date_time_picker/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class PickerOpener extends StatefulWidget {
  final Widget child;

  const PickerOpener({super.key, required this.child});

  @override
  State<PickerOpener> createState() => _PickerOpenerState();
}

class _PickerOpenerState extends State<PickerOpener> {
  final GlobalKey _key = GlobalKey();

  void _showPicker(BuildContext context) {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final spaceAbove = position.dy;
    final spaceBelow = MediaQuery.of(context).size.height -
        (position.dy + renderBox.size.height);

    if (spaceAbove > spaceBelow) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: spaceAbove,
            child: const DateTimePicker(),
          );
        },
        isScrollControlled: true,
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: spaceBelow,
            child: const DateTimePicker(),
          );
        },
        isScrollControlled: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () => _showPicker(context),
      child: widget.child,
    );
  }
}
