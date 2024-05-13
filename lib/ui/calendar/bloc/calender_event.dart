import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class CalendarEventInitFetched extends CalendarEvent {
  final DateTime? dateTime;
  const CalendarEventInitFetched(this.dateTime);

  @override
  List<Object?> get props => [];
}
