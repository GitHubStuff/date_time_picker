part of 'date_time_cubit.dart';

// ignore: constant_identifier_names
enum Median { AM, PM }

enum DateTimeType {
  date,
  time,
  both,
}

class DateTimeState {
  final DateTime dateTime;
  final Median median;
  final int daysInMonth;
  final bool jumpToDateTime;
  final bool showDate;
  final DateTimeType dateTimeType;

  DateTimeState(
    this.dateTime,
    this.median,
    this.daysInMonth, {
    this.jumpToDateTime = false,
    required this.showDate,
    required this.dateTimeType,
  });

  DateTimeState copyWith({
    DateTime? dateTime,
    Median? median,
    int? daysInMonth,
    bool? jumpToDateTime,
    bool? showDate,
    DateTimeType? dateTimeType,
  }) {
    return DateTimeState(
      dateTime ?? this.dateTime,
      median ?? this.median,
      daysInMonth ?? this.daysInMonth,
      jumpToDateTime: jumpToDateTime ?? this.jumpToDateTime,
      showDate: showDate ?? this.showDate,
      dateTimeType: dateTimeType ?? this.dateTimeType,
    );
  }
}
