import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/ui/people/bloc/people_event.dart';
import 'package:workmate/ui/people/bloc/people_state.dart';

import '../../../common/bloc/call_api.dart';
import '../../../model/user/user_info_data.dart';
import '../../../repository/firestore_repository.dart';
import '../../../repository/shared_preferences_repository.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final FireStoreRepository fireStoreRepository;
  PeopleBloc({required this.fireStoreRepository})
      : super(const PeopleState()) {
    on<PeopleEventInitFetched>(_onAccountInfoFetch);
    on<PeopleEventDeleteUser>(_onDeleteUser);
  }

  Future<void> _onAccountInfoFetch(
    PeopleEventInitFetched event,
    Emitter<PeopleState> emit,
  ) async {
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        final allUser = await fireStoreRepository.getUsersStream();
        final userID =await SharedPreferencesHelper.getStringType(
            SharedPreferencesHelper.keyUUID);
        print("Check User ID: " + userID);
        final user = await fireStoreRepository.findUserByUid(userID);
        emit(state.copyWith(usersStream: allUser, isAdmin: user.isAdmin));
      },
      onError: (e) {},
    );
  }

  void _onDeleteUser(PeopleEventDeleteUser event, Emitter<PeopleState> emit) async {
    print("onDeleteUser");
    fireStoreRepository.deleteUser(event.uuid);
  }
}
