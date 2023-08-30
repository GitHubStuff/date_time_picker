import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTimeCubit(DateTimeType dateTimeType)
      : super(DateTimeState(
            DateTime.now(),
            DateTime.now().hour >= 12 ? Median.PM : Median.AM,
            _daysInMonth(DateTime.now().month, DateTime.now().year),
            jumpToDateTime: true,
            showDate: true,
            dateTimeType: dateTimeType,
            dateTimeSet: false));

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

  void setDateTime() {
    final DateTime setTime = DateTime(
      state.dateTime.year,
      state.dateTime.month,
      state.dateTime.day,
      (displayTime) ? state.dateTime.hour : 0,
      (displayTime) ? state.dateTime.minute : 0,
      (displayTime) ? state.dateTime.second : 0,
    );
    emit(state.copyWith(dateTime: setTime, dateTimeSet: true));
  }

  void showPicker({required bool date}) => emit(state.copyWith(showDate: date));

  void updateYear(int year) => _updateDateTime(year: year);

  void updateMonth(int month) => _updateDateTime(month: month + 1);

  void updateDay(int day) => _updateDateTime(day: day);

  void updateHour(int hour) {
    if (state.median == Median.PM && hour != 12) hour += 12;
    if (state.median == Median.AM && hour == 12) hour = 0;

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
    // Calculate days in the specified month
    int daysInSpecifiedMonth = _daysInMonth(
        month ?? state.dateTime.month, year ?? state.dateTime.year);

    // Adjust day if it's greater than the days in the specified month
    day = day ?? state.dateTime.day;
    if (day > daysInSpecifiedMonth) {
      day = daysInSpecifiedMonth;
    }
    DateTime newDateTime = state.dateTime.copyWith(
      year: year ?? state.dateTime.year,
      month: month ?? state.dateTime.month,
      day: day,
      hour: hour ?? state.dateTime.hour,
      minute: minute ?? state.dateTime.minute,
      second: second ?? state.dateTime.second,
      millisecond: 0,
      microsecond: 0,
    );
    emit(DateTimeState(
      newDateTime,
      newDateTime.hour >= 12 ? Median.PM : Median.AM,
      _daysInMonth(newDateTime.month, newDateTime.year),
      showDate: showDate ?? state.showDate,
      dateTimeSet: state.dateTimeSet,
      dateTimeType: state.dateTimeType,
    ));
  }
}
