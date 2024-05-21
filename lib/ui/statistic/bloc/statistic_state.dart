part of 'statistic_bloc.dart';

enum StatisticType { sumOfActiveUser, userCreatedByTime, sumOfGroupChat }

class StatisticState extends BaseState {
  final StatisticType? selectedType;
  final int? activeUsers;
  final int? totalUsers;
  List<StatisticPoint>? dataUserCreate;

  StatisticState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.selectedType,
    this.activeUsers,
    this.totalUsers,
    this.dataUserCreate,
  }) : super(status: status, exception: exception);

  StatisticState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    StatisticType? selectedType,
    int? activeUsers,
    int? totalUsers,
    List<StatisticPoint>? dataUserCreate
  }) {
    return StatisticState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      selectedType: selectedType ?? this.selectedType,
      activeUsers: activeUsers ?? this.activeUsers,
      totalUsers: totalUsers ?? this.totalUsers,
      dataUserCreate: dataUserCreate?? this.dataUserCreate,
    );
  }

  @override
  List<Object?> get props =>
      super.props..addAll([selectedType, activeUsers, totalUsers, dataUserCreate]);
}
