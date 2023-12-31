import 'dart:async';

import 'package:date_time_picker/date_time_picker/cubit/date_time_broadcast.dart';
import 'package:date_time_picker/date_time_picker/cubit/date_time_cubit.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeDisplay extends StatefulWidget {
  const DateTimeDisplay({super.key});

  @override
  State<DateTimeDisplay> createState() => _DateTimeDisplayState();
}

class _DateTimeDisplayState extends State<DateTimeDisplay> {
  DateTime? _currentDateTime;
  Object? _id;
  late StreamSubscription<DateTimeBroadcast> _subscription;

  @override
  void initState() {
    super.initState();

    // Subscribe to the stream
    _subscription = DateTimeBroadcastManager.listen((broadcast) {
      setState(() {
        _currentDateTime = broadcast.dateTime;
        _id = broadcast.tag;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentDateTime == null) {
      return const CircularProgressIndicator(); // Display spinner
    } else {
      return Text(
          'Date and Time: ${_currentDateTime!.toLocal()} : ID:$_id'); // Display dateTime
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class Test extends StatelessWidget {
  final StreamController<DateTimeBroadcast> _messageController =
      StreamController<DateTimeBroadcast>.broadcast();

  Test({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateTimeCubit(
        broadcastId: 23.4,
        dateTimeType: DateTimeType.both,
        pickerMode: PickerMode.dark,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("DateTime Stream Test")),
        body: Builder(builder: (context) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // For the sake of demonstration, we're setting the current date time when the button is pressed.
                  BlocProvider.of<DateTimeCubit>(context).setDateTime(true);
                },
                child: const Text('Set Current DateTime'),
              ),
              ElevatedButton(
                onPressed: () {
                  // This will send a null dateTime, making the spinner appear.
                  _messageController.add(DateTimeBroadcast(null, 1));
                },
                child: const Text('Send Null DateTime'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
