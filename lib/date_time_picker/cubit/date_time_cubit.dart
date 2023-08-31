import 'dart:async';

import 'package:date_time_picker/date_time_picker/cubit/date_time_broadcast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  late final StreamController<DateTimeBroadcast>? _messageController;
  final int tag;

  DateTimeCubit({
    required this.tag,
    DateTime? initialDateTime,
    required DateTimeType dateTimeType,
    required StreamController<DateTimeBroadcast>? dateTimeBroadcast,
  })  : _messageController = dateTimeBroadcast,
        super(_initialState(dateTimeType, initialDateTime));

  static DateTimeState _initialState(
      DateTimeType dateTimeType, DateTime? initialDateTime) {
    final now = initialDateTime ?? DateTime.now();
    return DateTimeState(
      now,
      now.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(now.month, now.year),
      showDate: dateTimeType == DateTimeType.date ||
          dateTimeType == DateTimeType.both,
      dateTimeType: dateTimeType,
      jumpToDateTime: true,
    );
  }

  static int _daysInMonth(int month, int year) {
    List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return (month == 2 &&
            (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)))
        ? 29
        : monthDays[month - 1];
  }

  bool get displayDate =>
      state.dateTimeType == DateTimeType.date ||
      state.dateTimeType == DateTimeType.both;
  bool get displayTime =>
      state.dateTimeType == DateTimeType.time ||
      state.dateTimeType == DateTimeType.both;

  /// If 'true' will show the date selection widget, otherwise will show the time selection widget.
  void showPicker({required bool date}) => emit(state.copyWith(showDate: date));

  /// If true it will Broadcast the current DateTime, otherwise it will broadcast null.
  void setDateTime(bool dateTimeSet) {
    final setTime = DateTime(
      state.dateTime.year,
      state.dateTime.month,
      state.dateTime.day,
      displayTime ? state.dateTime.hour : 0,
      displayTime ? state.dateTime.minute : 0,
      displayTime ? state.dateTime.second : 0,
    );
    emit(state.copyWith(dateTime: setTime));
    _messageController?.add(DateTimeBroadcast(
      dateTimeSet ? setTime : null,
      tag,
    ));
  }

  void updateYear(int year) => _updateDateTime(year: year);
  void updateMonth(int month) => _updateDateTime(month: month + 1);
  void updateDay(int day) => _updateDateTime(day: day);
  void updateHour(int hour) {
    hour = (state.median == Median.PM && hour != 12) ? hour + 12 : hour;
    hour = (state.median == Median.AM && hour == 12) ? 0 : hour;
    _updateDateTime(hour: hour);
  }

  void updateMinute(int minute) => _updateDateTime(minute: minute);
  void updateSecond(int second) => _updateDateTime(second: second);

  void updateMedian(Median median) {
    int hour = state.dateTime.hour;
    if (median == Median.AM && hour >= 12) hour -= 12;
    if (median == Median.PM && hour < 12) hour += 12;
    _updateDateTime(hour: hour);
  }

  void _updateDateTime({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    bool? showDate,
  }) {
    final currentDateTime = state.dateTime;

    // Adjust day if it's greater than the days in the specified month
    day = day ?? currentDateTime.day;
    if (day >
        _daysInMonth(
            month ?? currentDateTime.month, year ?? currentDateTime.year)) {
      day = _daysInMonth(
          month ?? currentDateTime.month, year ?? currentDateTime.year);
    }

    DateTime newDateTime = currentDateTime.copyWith(
      year: year ?? currentDateTime.year,
      month: month ?? currentDateTime.month,
      day: day,
      hour: hour ?? currentDateTime.hour,
      minute: minute ?? currentDateTime.minute,
      second: second ?? currentDateTime.second,
      millisecond: 0,
      microsecond: 0,
    );

    emit(state.copyWith(
      dateTime: newDateTime,
      median: newDateTime.hour >= 12 ? Median.PM : Median.AM,
      daysInMonth: _daysInMonth(newDateTime.month, newDateTime.year),
      showDate: showDate ?? state.showDate,
    ));
  }
}
