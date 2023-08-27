import 'package:flutter_bloc/flutter_bloc.dart';

class DateState {
  final DateTime dateTime;
  final int daysInMonth;
  final bool jumpToDate;

  DateState(this.dateTime, this.daysInMonth, {this.jumpToDate = false});
}

class DateCubit extends Cubit<DateState> {
  DateCubit()
      : super(DateState(
          DateTime.now(),
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
    emit(DateState(
      dateTime,
      _daysInMonth(dateTime.month, dateTime.year),
      jumpToDate: true,
    ));
  }

  void updateYear(int year) {
    if (year < 1900 || year > 2200) return;

    int month = state.dateTime.month;
    int day = state.dateTime.day;

    int daysInNewMonth = _daysInMonth(month, year);
    if (day > daysInNewMonth) {
      day = daysInNewMonth;
    }

    DateTime newDateTime = DateTime(year, month, day);

    emit(DateState(newDateTime, daysInNewMonth));
  }

  void updateMonth(int month) {
    if (month < 0 || month > 11) return;

    int year = state.dateTime.year;
    int day = state.dateTime.day;

    month++;
    int daysInNewMonth = _daysInMonth(month, year);
    if (day > daysInNewMonth) {
      day = daysInNewMonth;
    }

    DateTime newDateTime = DateTime(year, month, day);

    emit(DateState(newDateTime, daysInNewMonth));
  }

  void updateDay(int day) {
    if (day < 1 || day > state.daysInMonth) return;

    int year = state.dateTime.year;
    int month = state.dateTime.month;

    DateTime newDateTime = DateTime(year, month, day);
    emit(DateState(newDateTime, state.daysInMonth));
  }
}
