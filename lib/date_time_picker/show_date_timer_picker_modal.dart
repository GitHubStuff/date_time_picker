import 'package:date_time_picker/date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

Future<void> showDateTimePickerModal(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true, // To let it cover the entire screen
    backgroundColor: Colors.transparent, // Making the modal itself transparent
    builder: (BuildContext context) {
      return const DateTimePickerModalContent();
    },
  );
}

class DateTimePickerModalContent extends StatelessWidget {
  const DateTimePickerModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pop(context),
      behavior: HitTestBehavior.opaque, // Dismiss the modal when tapping outside
      child: Container(
        color: Colors.black45, // Slightly obscure the background
        child: const Center(
          child: FractionallySizedBox(
            widthFactor: 0.9, // adjust to your preference
            heightFactor: 0.6, // adjust to your preference
            child: DateTimePicker(), // Your provided DateTimePicker widget
          ),
        ),
      ),
    );
  }
}
