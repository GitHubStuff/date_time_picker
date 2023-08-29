import 'package:date_time_picker/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class PickerOpener extends StatefulWidget {
  final Widget child;
  final Widget setWidget;
  final String dateTimeFormat;
  final Widget dateCaption;
  final Widget timeCaption;
  const PickerOpener({
    Key? key,
    required this.child,
    required this.setWidget,
    required this.dateTimeFormat,
    required this.dateCaption,
    required this.timeCaption,
  }) : super(key: key);

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

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        if (spaceAbove > spaceBelow) {
          return pickerContainer(spaceAbove);
        } else {
          return pickerContainer(spaceBelow);
        }
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // make it transparent
    );
  }

  Widget pickerContainer(double height) {
    return GestureDetector(
      onTap: () {},
      onVerticalDragDown: (details) {
        Navigator.pop(context); // Close the bottom sheet on drag down
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: height,
        child: DateTimePicker(
          dateCaption: widget.dateCaption,
          timeCaption: widget.timeCaption,
          dateTimeFormat: widget.dateTimeFormat,
          setDateTimeWidget: widget.setWidget,
        ),
      ),
    );
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
