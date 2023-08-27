import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: constant_identifier_names
enum Median { AM, PM }

class DateTimeState {
  final DateTime dateTime;
  final Median median;
  final int daysInMonth;
  final bool jumpToDateTime;
  final bool showDate;

  DateTimeState(
    this.dateTime,
    this.median,
    this.daysInMonth, {
    this.jumpToDateTime = false,
    required this.showDate,
  });
}

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTimeCubit()
      : super(DateTimeState(
          DateTime.now(),
          DateTime.now().hour >= 12 ? Median.PM : Median.AM,
          _daysInMonth(DateTime.now().month, DateTime.now().year),
          jumpToDateTime: true,
          showDate: true,
        ));

  static int _daysInMonth(int month, int year) {
    List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    return (month == 2 &&
            (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)))
        ? 29
        : monthDays[month - 1];
  }

  void jumpTo(DateTime dateTime) {
    final Random random = Random();
    emit(DateTimeState(
      dateTime,
      dateTime.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(dateTime.month, dateTime.year),
      jumpToDateTime: true,
      showDate: random.nextBool(),
    ));
  }

  void updateYear(int year) {
    updateDateTime(year: year);
  }

  void updateMonth(int month) {
    updateDateTime(month: month + 1);
  }

  void updateDay(int day) {
    updateDateTime(day: day);
  }

  void updateHour(int hour) {
    if (state.median == Median.PM && hour != 12) hour += 12;
    if (state.median == Median.AM && hour == 12) hour = 0;

    updateDateTime(hour: hour);
  }

  void updateMinute(int minute) {
    updateDateTime(minute: minute);
  }

  void updateSecond(int second) {
    updateDateTime(second: second);
  }

  void updateMedian(Median median) {
    int hour = state.dateTime.hour;

    // Convert 24-hour format to 12-hour format
    if (median == Median.AM && hour >= 12) hour -= 12;
    if (median == Median.PM && hour < 12) hour += 12;

    updateDateTime(hour: hour);
  }

  void updateDateTime({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    bool? showDate,
  }) {
    DateTime newDateTime = state.dateTime.copyWith(
      year: year ?? state.dateTime.year,
      month: month ?? state.dateTime.month,
      day: day ?? state.dateTime.day,
      hour: hour ?? state.dateTime.hour,
      minute: minute ?? state.dateTime.minute,
      second: second ?? state.dateTime.second,
      millisecond: 0,
      microsecond: 0,
    );
    debugPrint('New DateTime: $newDateTime');
    emit(DateTimeState(
      newDateTime,
      newDateTime.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(newDateTime.month, newDateTime.year),
      showDate: showDate ?? state.showDate,
    ));
  }
}
