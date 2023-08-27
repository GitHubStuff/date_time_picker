import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: constant_identifier_names
enum Median { AM, PM }

class DateTimeState {
  final DateTime dateTime;
  final Median median;
  final int daysInMonth;
  final bool jumpToDateTime;

  DateTimeState(this.dateTime, this.median, this.daysInMonth,
      {this.jumpToDateTime = false});
}

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTimeCubit()
      : super(DateTimeState(
          DateTime.now(),
          DateTime.now().hour >= 12 ? Median.PM : Median.AM,
          _daysInMonth(DateTime.now().month, DateTime.now().year),
        ));

  static int _daysInMonth(int month, int year) {
    List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month == 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
      return 29;
    }
    return monthDays[month - 1];
  }

  void jumpTo(DateTime dateTime) {
    emit(DateTimeState(
      dateTime,
      dateTime.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(dateTime.month, dateTime.year),
      jumpToDateTime: true,
    ));
  }

  void updateYear(int year) {
    if (year < 1900 || year > 2200) return;
    updateDateTime(year: year);
  }

  void updateMonth(int month) {
    if (month < 0 || month > 11) return;
    updateDateTime(month: month + 1);
  }

  void updateDay(int day) {
    if (day < 1 || day > state.daysInMonth) return;
    updateDateTime(day: day);
  }

  void updateHour(int hour) {
    if (hour < 1 || hour > 12) return;

    // Convert 12-hour format to 24-hour format
    if (state.median == Median.PM && hour != 12) hour += 12;
    if (state.median == Median.AM && hour == 12) hour = 0;

    updateDateTime(hour: hour);
  }

  void updateMinute(int minute) {
    if (minute < 0 || minute > 59) return;
    updateDateTime(minute: minute);
  }

  void updateSecond(int second) {
    if (second < 0 || second > 59) return;
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
  }) {
    DateTime newDateTime = state.dateTime.copyWith(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      millisecond: 0,
      microsecond: 0,
    );
    emit(DateTimeState(
      newDateTime,
      newDateTime.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(newDateTime.month, newDateTime.year),
    ));
  }
}
