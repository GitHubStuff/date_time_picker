import 'package:date_time_picker/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

void showDateTimePickerModal(BuildContext context,
    {double? top, double? left}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Modal",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) =>
        DateTimePickerModalContent(top: top, left: left),
  );
}

class DateTimePickerModalContent extends StatelessWidget {
  final double? top;
  final double? left;
  final double width = 230.0; // Provide your known width
  final double height = 56.0 * 7; // Provide your known height

  const DateTimePickerModalContent({Key? key, this.top, this.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate center position if top and left aren't provided
    final defaultTop = (screenHeight - height) / 2;
    final defaultLeft = (screenWidth - width) / 2;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.black45,
        child: Stack(
          children: [
            Positioned(
              top: top ?? defaultTop,
              left: left ?? defaultLeft,
              child: Container(
                width: width,
                height: height,
                color:
                    Colors.transparent, // Ensure the container is transparent
                child:
                    const DateTimePicker(), // Assuming this is the widget you want to show
              ),
            ),
          ],
        ),
      ),
    );
  }
}
