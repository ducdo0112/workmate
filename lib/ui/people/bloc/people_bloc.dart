import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/ui/people/bloc/people_event.dart';
import 'package:workmate/ui/people/bloc/people_state.dart';

import '../../../common/bloc/call_api.dart';
import '../../../repository/firestore_repository.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final FireStoreRepository fireStoreRepository;
  PeopleBloc({required this.fireStoreRepository})
      : super(const PeopleState(users: [], filteredUsers: [])) {
    on<PeopleEventInitFetched>(_onAccountInfoFetch);
    on<PeopleEventSearch>(_onSearchUser);
  }

  Future<void> _onAccountInfoFetch(
    PeopleEventInitFetched event,
    Emitter<PeopleState> emit,
  ) async {
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        final users = await fireStoreRepository.getAllExceptMe();
        emit(state.copyWith(users: users));
      },
      onError: (e) {},
    );
  }

  void _onSearchUser(PeopleEventSearch event, Emitter<PeopleState> emit) {
    final query = event.query.toLowerCase();
    final filteredUsers = state.users.where((user) {
      final fullName = user.fullName.toLowerCase();
      final email = user.email.toLowerCase();
      return fullName.contains(query) || email.contains(query);
    }).toList();
    emit(state.copyWith(filteredUsers: filteredUsers));
  }
}
