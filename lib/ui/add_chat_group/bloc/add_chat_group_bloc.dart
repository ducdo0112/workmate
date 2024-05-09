import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/repository/shared_preferences_repository.dart';

import '../../../common/bloc/call_api.dart';
import '../../../model/enum/bloc_status.dart';
import '../../../model/user/user_info_data.dart';
import '../../../repository/firestore_repository.dart';
import 'add_chat_group_event.dart';
import 'add_chat_group_state.dart';

class AddChatGroupBloc extends Bloc<AddChatGroupEvent, AddChatGroupState> {
  final FireStoreRepository fireStoreRepository;

  AddChatGroupBloc({required this.fireStoreRepository})
      : super(const AddChatGroupState()) {
    on<AddChatGroupFetched>(_onAccountInfoFetch);
    on<ChangeUserSelected>(_onUserSelectedChanged);
    on<CreateGroupPressed>(_onGroupCreatePressed);
    on<GroupNameChanged>(_onGroupNameChanged);
    on<CreateGroupPrivateWithUserSelected>(_onPrivateGroupCreatePressed);
  }

  Future<void> _onAccountInfoFetch(
    AddChatGroupFetched event,
    Emitter<AddChatGroupState> emit,
  ) async {
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        emit(state.copyWith(status: BlocStatus.loading));
        var result = await fireStoreRepository.getAllUser();
        final currentUser = FirebaseAuth.instance.currentUser?.uid;
        if (currentUser != null) {
          result =
              result.where((element) => element.uid != currentUser).toList();
        }
        emit(state.copyWith(status: BlocStatus.success, listUsers: result));
      },
      onError: (e) {
        emit(state.copyWith(status: BlocStatus.error));
      },
    );
  }

  void _onUserSelectedChanged(
    ChangeUserSelected event,
    Emitter<AddChatGroupState> emit,
  ) {
    final currentUserSelected = [...?state.listUsersSelected];
    if (event.isAdd) {
      currentUserSelected.add(event.userInfoData);
    } else {
      currentUserSelected.remove(event.userInfoData);
    }

    emit(state.copyWith(listUsersSelected: currentUserSelected));
  }

  Future<void> _onGroupCreatePressed(
    CreateGroupPressed event,
    Emitter<AddChatGroupState> emit,
  ) async {
    if (_isValidateSuccessInput(emit)) {
      await handleCallApi(
        onNoInternet: (e) {},
        onCallApi: () async {
          emit(state.copyWith(statusCreateGroup: BlocStatus.loading));
          final listUuidUser = <String>[];
          final listUserName = <String>[];
          final listUserSelected = state.listUsersSelected ?? [];
          for (var i = 0; i < listUserSelected.length; i++) {
            listUuidUser.add(listUserSelected[i].uid);
            listUserName.add(listUserSelected[i].fullName);
          }

          final email = await SharedPreferencesHelper.getStringType(
              SharedPreferencesHelper.keyEmail);
          QuerySnapshot userInfoSnapshot = await FireStoreRepository(
                  uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          final adminUser = UserInfoData.fromQuerySnapshot(userInfoSnapshot);

          listUuidUser.add(adminUser.uid);
          listUserName.add(adminUser.fullName);

          final groupId = await FireStoreRepository(uid: adminUser.uid)
              .createGroup(adminUser.fullName, adminUser.uid, state.groupName,
                  listUuidUser, listUserName);
          emit(state.copyWith(
              statusCreateGroup: BlocStatus.success,
              groupId: groupId,
              emailAdmin: email,
              isAdmin: true,
              avatarAdmin: adminUser.profilePic,
              usernameAdmin: adminUser.fullName,
              isPrivateGroup: false));
        },
        onError: (e) {
          emit(state.copyWith(statusCreateGroup: BlocStatus.error));
        },
      );
    }
  }

  Future<void> _onPrivateGroupCreatePressed(
    CreateGroupPrivateWithUserSelected event,
    Emitter<AddChatGroupState> emit,
  ) async {
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        emit(state.copyWith(
            statusCreatePrivateGroup: BlocStatus.loading,
            status: BlocStatus.loading));
        final listUuidUser = <String>[];
        final listUserName = <String>[];

        final email = await SharedPreferencesHelper.getStringType(
            SharedPreferencesHelper.keyEmail);
        QuerySnapshot userInfoSnapshot = await FireStoreRepository(
                uid: FirebaseAuth.instance.currentUser!.uid)
            .gettingUserData(email);
        final adminUser = UserInfoData.fromQuerySnapshot(userInfoSnapshot);
        final otherUser = event.userInfoData;

        listUuidUser.add(adminUser.uid);
        listUuidUser.add(otherUser.uid);

        listUserName.add(adminUser.fullName);
        listUserName.add(otherUser.fullName);

        final groupId = await FireStoreRepository(uid: adminUser.uid)
            .createPrivateGroup(adminUser.fullName, adminUser.uid,
                state.groupName, listUuidUser, listUserName);
        emit(state.copyWith(
            statusCreatePrivateGroup: BlocStatus.success,
            groupId: groupId,
            emailAdmin: email,
            avatarAdmin: adminUser.profilePic,
            usernameAdmin: adminUser.fullName,
            status: BlocStatus.success,
            isPrivateGroup: true,
            isAdmin: true,
            username1: adminUser.fullName,
            username2: otherUser.fullName));
      },
      onError: (e) {
        emit(state.copyWith(
            statusCreatePrivateGroup: BlocStatus.error,
            status: BlocStatus.error));
      },
    );
  }

  bool _isValidateSuccessInput(Emitter<AddChatGroupState> emit) {
    // username
    bool showErrorInputGroupName = false;
    if (state.groupName.isEmpty) {
      showErrorInputGroupName = true;
    }

    // email
    bool showErrorSelectUser = false;
    if ((state.listUsersSelected?.length ?? 0) <= 0) {
      showErrorSelectUser = true;
    }

    emit(state.copyWith(
      shouldShowErrorInputNameGroup: showErrorInputGroupName,
      shouldShowErrorSelectUser: showErrorSelectUser,
    ));

    if (showErrorInputGroupName || showErrorSelectUser) {
      return false;
    }

    return true;
  }

  void _onGroupNameChanged(
    GroupNameChanged event,
    Emitter<AddChatGroupState> emit,
  ) {
    emit(state.copyWith(groupName: event.nameGroup));
  }
}
