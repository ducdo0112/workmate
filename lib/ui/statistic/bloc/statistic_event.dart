part of 'statistic_bloc.dart';

abstract class StatisticEvent extends Equatable {
  const StatisticEvent();
}


class SelectStatisticTypeEvent extends StatisticEvent {
  final StatisticType type;

  const SelectStatisticTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}