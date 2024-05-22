part of 'statistic_bloc.dart';

enum StatisticType { sumOfActiveUser, userCreatedByTime, sumOfGroupChat }

class StatisticState extends BaseState {
  final StatisticType? selectedType;
  final Stream? usersStream;

  const StatisticState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.selectedType,
    this.usersStream,
  }) : super(status: status, exception: exception);

  StatisticState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    StatisticType? selectedType,
    final Stream? usersStream
  }) {
    return StatisticState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      selectedType: selectedType ?? this.selectedType,
      usersStream: usersStream ?? this.usersStream
    );
  }

  @override
  List<Object?> get props =>
      super.props..addAll([selectedType, usersStream]);
}
