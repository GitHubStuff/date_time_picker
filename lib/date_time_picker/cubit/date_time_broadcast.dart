import 'dart:async';

class DateTimeBroadcast {
  final DateTime? dateTime;
  final Object tag;

  DateTimeBroadcast(this.dateTime, this.tag);
}

class DateTimeBroadcastManager {
  DateTimeBroadcastManager._();

  static final StreamController<DateTimeBroadcast> _messageController =
      StreamController<DateTimeBroadcast>.broadcast();

  static void broadcast(DateTime? dateTime, Object? tag) {
    if (tag != null) _messageController.add(DateTimeBroadcast(dateTime, tag));
  }

  // Static method to get a stream for listening.
  static Stream<DateTimeBroadcast> get dateTimeStream =>
      _messageController.stream;

  static StreamSubscription<DateTimeBroadcast> listen(
          void Function(DateTimeBroadcast) callback) =>
      _messageController.stream.listen(callback);

  // Static cleanup method.
  static void dispose() {
    _messageController.close();
  }
}
