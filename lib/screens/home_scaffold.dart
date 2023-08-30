import 'package:date_time_picker/date_time_picker/aqua_button.dart';
import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:date_time_picker/date_time_picker/modals/positioned_date_time_modal.dart';
import 'package:flutter/material.dart';

const String _dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a';
const TextStyle _textStyle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xffffa500));

Widget get _dateCaption => const Text('Date', style: _textStyle);
Widget get _timeCaption => const Text('Time', style: _textStyle);

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    // PickerStyles.init(
    //   dateColor: Colors.blue,
    //   timeColor: Colors.purple,
    //   headerColor: Colors.blueGrey,
    //   headerStyle: _headerStyle,
    //   textStyle: _textStyle,
    // );
    // PickerStyles.init(
    //   dateColor: Colors.red,
    //   timeColor: Colors.green,
    //   headerColor: Colors.blue,
    //   headerStyle: _headerStyle,
    //   textStyle: _textStyle,
    // );
    PickerStyles.init();
    final DateTimeCubit dateTimeCubit1 = DateTimeCubit(DateTimeType.date);
    final DateTimeCubit dateTimeCubit2 = DateTimeCubit(DateTimeType.date);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: () async {
              await showDateTimePickerModal(
                context,
                dateTimeCubit: dateTimeCubit1,
                barrierColor: const Color(0x0f000000),
                dateTimeFormat: _dateTimeFormat,
                setWidget: const Text('Set', style: _textStyle),
                dateCaption: _dateCaption,
                timeCaption: _timeCaption,
              );
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
            dateTimeCubit: dateTimeCubit2,
            setWidget: const AquaButton(),
            dateCaption: _dateCaption,
            timeCaption: _timeCaption,
            pickerSize: PickerStyles.pickerSize,
            child: const Text(
              'Tap This!',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ],
    );
  }
}
