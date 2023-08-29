part of 'date_time_cubit.dart';
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

  DateTimeState copyWith({
    DateTime? dateTime,
    Median? median,
    int? daysInMonth,
    bool? jumpToDateTime,
    bool? showDate,
  }) {
    return DateTimeState(
      dateTime ?? this.dateTime,
      median ?? this.median,
      daysInMonth ?? this.daysInMonth,
      jumpToDateTime: jumpToDateTime ?? this.jumpToDateTime,
      showDate: showDate ?? this.showDate,
    );
  }
}
