import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/bloc/base_state.dart';
import '../../../model/enum/bloc_status.dart';
import '../../../model/http_raw/network_exception.dart';
import '../../../model/statistic/statistic_point.dart';
import '../../../repository/firestore_repository.dart';
import '../../../utils/hepler_function.dart';

part 'statistic_event.dart';

part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final FireStoreRepository fireStoreRepository;

  StatisticBloc({required this.fireStoreRepository})
      : super(const StatisticState()) {
    on<SelectStatisticTypeEvent>(_onSelectStatisticType);
  }

  Future<void> _onSelectStatisticType(
      SelectStatisticTypeEvent event, Emitter<StatisticState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    // SUM OF USERS
    final allUser = await fireStoreRepository.getUsersStream();

    emit(state.copyWith(
        status: BlocStatus.success,
        selectedType: event.type,
        usersStream: allUser));
  }
}

// final activeUsers =
//     allUser.where((user) => user.status == "Hoạt động").length;
// final totalUsers = allUser.length;
//
// final currentMonth = DateTime.now().month;
//
// // Prepare data for StatisticPoint list
// final List<StatisticPoint> data = [];
//
// // Iterate from current month to January
// for (int monthIndex = 1; monthIndex <= currentMonth; monthIndex++) {
// // Filter users with createDate in the current month
// final usersInMonth = allUser
//     .where((user) => user.createdDate.month == monthIndex)
//     .toList();
// final totalUsersInMonth = usersInMonth.length;
//
// // Add data point to the list
// data.add(StatisticPoint(getMonthName(monthIndex), totalUsersInMonth));
// }
//
// data.forEach((element) {
// print("${element.month} - ${element.value}");
// });
