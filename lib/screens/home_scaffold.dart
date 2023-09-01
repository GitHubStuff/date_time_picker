import 'dart:async';

import 'package:date_time_picker/date_time_picker/aqua_button.dart';
import 'package:date_time_picker/date_time_picker/cubit/date_time_broadcast.dart';
import 'package:date_time_picker/date_time_picker/integration/date_time_display.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:date_time_picker/date_time_picker/modals/positioned_date_time_modal.dart';
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xffffa500));

Widget get _dateCaption => const Text('Date', style: _textStyle);
Widget get _timeCaption => const Text('Time', style: _textStyle);

final StreamController<DateTimeBroadcast> messageController =
    StreamController<DateTimeBroadcast>.broadcast();

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    //return Test();
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    PickerStyling.init();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const DateTimeDisplay(),
        ElevatedButton(
            onPressed: () async {
              final t = await showDateTimePickerModal(
                context,
                pickerMode: PickerMode.dark,
                useSeconds: true,
                broadcastId: GlobalKey(),
                barrierColor: const Color(0x0f000000),
                setWidget: const AquaButton(color: Colors.amber),
                dateCaption: _dateCaption,
                timeCaption: _timeCaption,
                messageController: messageController,
              );
              debugPrint('T:$t');
            },
            child: const Text('Show Picker')),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: PositionedDateTimeModal(
            sidePriority: const [
              Sides.centerBottom,
              Sides.right,
              Sides.left,
              Sides.centerTop,
              Sides.top,
              Sides.bottom
            ],
            useSeconds: false,
            pickerMode: PickerMode.light,
            setWidget: const AquaButton(),
            dateCaption: null, //_dateCaption,
            timeCaption: _timeCaption,
            pickerSize: PickerStyling.pickerSize,
            dateTimeBroadcast: messageController,
            child: const Text(
              'Tap This!',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: PositionedDateTimeModal(
            sidePriority: const [
              Sides.centerBottom,
              Sides.right,
              Sides.left,
              Sides.centerTop,
              Sides.top,
              Sides.bottom
            ],
            useSeconds: false,
            pickerMode: PickerMode.light,
            setWidget: const AquaButton(),
            dateCaption: _dateCaption,
            timeCaption: null, //_timeCaption,
            pickerSize: PickerStyling.pickerSize,
            dateTimeBroadcast: messageController,
            child: const Text(
              'Or This!',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ],
    );
  }
}
