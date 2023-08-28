import 'package:date_time_picker/date_time_picker/position_modal.dart';
import 'package:date_time_picker/date_time_picker/show_date_timer_picker_modal.dart';
import 'package:date_time_picker/date_time_picker/tappable_date_time_picker.dart';
import 'package:flutter/material.dart';


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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await showDateTimePickerModal(context, top: 100, left: 10);
                debugPrint('Zerk 🟣');
              },
              child: const PickerOpener(child: Text('Zibby'))),
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
                showDateTimePickerModal(context);
                debugPrint('Zerk 🔸');
              },
              child: const Text('Show Picker')),
          ElevatedButton(
            onPressed: () async {
              showDateTimePickerModal(context);
              debugPrint('Zerk 🔸');
            },
            child: const PickerOpener(child: Text('Popover')),
          ),

          const Padding(
            padding: EdgeInsets.all(12.0),
            child: PositionModal(
              child: Text(
                'Tap This!',
                style: TextStyle(fontSize: 44.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
