import 'package:date_time_picker/date_time_picker/cubit/date_time_broadcast.dart';
import 'package:date_time_picker/date_time_picker/picker_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  final Object? broadcastId;

  DateTimeCubit({
    this.broadcastId,
    DateTime? initialDateTime,
    required DateTimeType dateTimeType,
    required PickerMode pickerMode,
  }) : super(_initialState(dateTimeType, initialDateTime, pickerMode));

  // Getters for display properties
  bool get displayDate =>
      state.dateTimeType == DateTimeType.date ||
      state.dateTimeType == DateTimeType.both;

  bool get displayTime =>
      state.dateTimeType == DateTimeType.time ||
      state.dateTimeType == DateTimeType.both;

  bool get displayTimeWithSeconds =>
      state.dateTimeType == DateTimeType.timeWithSeconds ||
      state.dateTimeType == DateTimeType.bothWithSeconds;

  // Public methods for UI actions
  /// Toggles the visibility of the picker between date and time.
  void showPicker({required bool date}) => emit(state.copyWith(showDate: date));

  /// Broadcasts the current DateTime or null based on the provided flag.
  void setDateTime(bool dateTimeSet) {
    final setTime = DateTime(
      state.dateTime.year,
      state.dateTime.month,
      state.dateTime.day,
      displayTime ? state.dateTime.hour : 0,
      displayTime ? state.dateTime.minute : 0,
      displayTimeWithSeconds ? state.dateTime.second : 0,
    );
    emit(state.copyWith(dateTime: setTime));
    DateTimeBroadcastManager.broadcast(
      dateTimeSet ? setTime : null,
      broadcastId,
    );
  }

  // Update methods
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

  // Private utility methods
  static DateTimeState _initialState(
    DateTimeType dateTimeType,
    DateTime? initialDateTime,
    PickerMode mode,
  ) {
    final now = initialDateTime ?? DateTime.now();
    return DateTimeState(
      now,
      now.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(now.month, now.year),
      showDate: dateTimeType == DateTimeType.date ||
          dateTimeType == DateTimeType.both,
      dateTimeType: dateTimeType,
      jumpToDateTime: true,
      pickerMode: mode,
    );
  }

  static int _daysInMonth(int month, int year) {
    List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return (month == 2 &&
            (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)))
        ? 29
        : monthDays[month - 1];
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

    final currentDayCount =
        _daysInMonth(currentDateTime.month, currentDateTime.year);
    final daysInMonth = _daysInMonth(
        month ?? currentDateTime.month, year ?? currentDateTime.year);

    // Adjust day if it's greater than the days in the specified month
    day = day ?? currentDateTime.day;
    if (day > daysInMonth) {
      day = daysInMonth;
    }

    DateTime newDateTime = currentDateTime.copyWith(
      year: year ?? currentDateTime.year,
      month: month ?? currentDateTime.month,
      day: day,
      hour: hour ?? currentDateTime.hour,
      minute: minute ?? currentDateTime.minute,
      second: displayTimeWithSeconds ?  (second ?? currentDateTime.second) : 0,
      millisecond: 0,
      microsecond: 0,
    );

    emit(state.copyWith(
      dateTime: newDateTime,
      median: newDateTime.hour >= 12 ? Median.PM : Median.AM,
      daysInMonth: _daysInMonth(newDateTime.month, newDateTime.year),
      showDate: showDate ?? state.showDate,
      jumpToDateTime:
          day != currentDateTime.day || currentDayCount != daysInMonth,
    ));
  }
}
