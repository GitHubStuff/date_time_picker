import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:date_time_picker/date_time_picker/modals/position_modal.dart';
import 'package:date_time_picker/date_time_picker/modals/show_date_timer_picker_modal.dart';
import 'package:date_time_picker/date_time_picker/modals/side_modal.dart';
import 'package:date_time_picker/date_time_picker/pill_button.dart';
import 'package:date_time_picker/date_time_picker/tappable_date_time_picker.dart';
import 'package:flutter/material.dart';

const String _dateTimeFormat = 'EEE MMM d, y\nh:mm:ss a';
const TextStyle _textStyle = TextStyle(
    fontSize: 20.0, fontWeight: FontWeight.w500, color: Color(0xffffa500));
const TextStyle _headerStyle = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xffffa500));

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
    PickerStyles.init(
      dateColor: Colors.blue,
      timeColor: Colors.purple,
      headerColor: Colors.blueGrey,
      headerStyle: _headerStyle,
      textStyle: _textStyle,
    );
    PickerStyles.init(
      dateColor: Colors.red,
      timeColor: Colors.green,
      headerColor: Colors.blue,
      headerStyle: _headerStyle,
      textStyle: _textStyle,
    );
    //PickerStyles.init();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () async {
              await showDateTimePickerModal(
                context,
                top: 100,
                left: 10,
                dateCaption: _dateCaption,
                timeCaption: _timeCaption,
              );
              debugPrint('Zerk 🟣');
            },
            child: PickerOpener(
                dateCaption: _dateCaption,
                timeCaption: _timeCaption,
                setWidget: const AquaButton(),
                dateTimeFormat: _dateTimeFormat,
                child: const Text('Zibby')),
          ),
          // SizedBox(
          //   width: 200,
          //   height: 200,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Assets.images.ltmm1024x1024.image(),
          //   ),
          // ),
          //const DateTimePicker(),
          ElevatedButton(
              onPressed: () async {
                showDateTimePickerModal(
                  context,
                  dateCaption: _dateCaption,
                  timeCaption: _timeCaption,
                );
                debugPrint('Zerk 🔸');
              },
              child: const Text('Show Picker')),
          ElevatedButton(
            onPressed: () async {
              showDateTimePickerModal(
                context,
                dateCaption: _dateCaption,
                timeCaption: _timeCaption,
              );
              debugPrint('Zerk 🔸');
            },
            child: PickerOpener(
              dateCaption: _dateCaption,
              timeCaption: _timeCaption,
              setWidget: const AquaButton(),
              dateTimeFormat: _dateTimeFormat,
              child: const Text('Popover'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PositionModal(
              dateCaption: _dateCaption,
              timeCaption: _timeCaption,
              child: const Text(
                'Side Swipe',
                style: TextStyle(fontSize: 44.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SideModal(
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
      ),
    );
  }
}
