import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/ui/calendar/bloc/calender_event.dart';
import 'package:workmate/ui/calendar/bloc/calender_state.dart';
import 'package:workmate/utils/timestamp.dart';

import '../../../common/bloc/call_api.dart';
import '../../../model/enum/bloc_status.dart';
import '../../../model/user/user_info_data.dart';
import '../../../repository/firestore_repository.dart';
import '../../../repository/shared_preferences_repository.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final FireStoreRepository fireStoreRepository;

  CalendarBloc({required this.fireStoreRepository})
      : super(const CalendarState()) {
    on<CalendarEventInitFetched>(_onAccountInfoFetch);
  }

  Future<void> _onAccountInfoFetch(
    CalendarEventInitFetched event,
    Emitter<CalendarState> emit,
  ) async {
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        emit(state.copyWith(status: BlocStatus.loading));
        final email = await SharedPreferencesHelper.getStringType(
            SharedPreferencesHelper.keyEmail);
        if (email.isNotEmpty) {
          QuerySnapshot userInfoSnapshot = await FireStoreRepository(
                  uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          final user = UserInfoData.fromQuerySnapshot(userInfoSnapshot);
          final eventStream = await fireStoreRepository.getListEventByDate(
              TimestampUtil.formatTimeDDMMYYYY(
                  event.dateTime ?? DateTime.now()));
          emit(state.copyWith(
              status: BlocStatus.success,
              user: user,
              dateTimeSelected: event.dateTime ?? DateTime.now(),
              startDateTimeOfMonthSelect: getMonthStartDate(),
              endDateTimeOfMonthSelect: getMonthEndDate(),
              eventsStream: eventStream));
        } else {
          emit(state.copyWith(status: BlocStatus.error));
        }
      },
      onError: (e) {
        emit(state.copyWith(status: BlocStatus.error));
      },
    );
  }

  DateTime getMonthStartDate() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  DateTime getMonthEndDate() {
    DateTime now = DateTime.now();
    int lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
    return DateTime(now.year, now.month, lastDayOfMonth);
  }
}
