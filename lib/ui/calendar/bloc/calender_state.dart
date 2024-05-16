import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

import '../../../model/user/user_info_data.dart';

class CalendarState extends BaseState {
  final UserInfoData? user;
  final DateTime? dateTimeSelected;
  final DateTime? startDateTimeOfMonthSelect;
  final DateTime? endDateTimeOfMonthSelect;

  final Stream? eventsStream;
  final bool needRebuildAppBar;

  const CalendarState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.dateTimeSelected,
    this.user,
    this.startDateTimeOfMonthSelect,
    this.endDateTimeOfMonthSelect,
    this.eventsStream,
    this.needRebuildAppBar = false,
  }) : super(status: status, exception: exception);

  CalendarState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    UserInfoData? user,
    DateTime? dateTimeSelected,
    DateTime? startDateTimeOfMonthSelect,
    DateTime? endDateTimeOfMonthSelect,
    Stream? eventsStream,
    bool? needRebuildAppBar
  }) =>
      CalendarState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        user: user ?? this.user,
        eventsStream: eventsStream ?? this.eventsStream,
        dateTimeSelected: dateTimeSelected ?? this.dateTimeSelected,
        startDateTimeOfMonthSelect:
            startDateTimeOfMonthSelect ?? this.startDateTimeOfMonthSelect,
        endDateTimeOfMonthSelect:
            endDateTimeOfMonthSelect ?? this.endDateTimeOfMonthSelect,
        needRebuildAppBar: needRebuildAppBar ?? this.needRebuildAppBar,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      user,
      dateTimeSelected,
      startDateTimeOfMonthSelect,
      endDateTimeOfMonthSelect,
      eventsStream,
      needRebuildAppBar
    ]);
}
