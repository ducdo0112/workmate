import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/common/bloc/call_api.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/repository/shared_preferences_repository.dart';
import 'dart:io' as io;
import 'dart:convert';

part 'account_info_event.dart';

part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  final AuthRepository authRepository;

  AccountInfoBloc({required this.authRepository})
      : super(const AccountInfoState()) {
    on<AccountInfoEventFetch>(_onAccountInfoFetch);
    on<AccountEventAvatarChanged>(_onAccountEventAvatarChanged);
    on<AccountEventUpdatePressed>(_onAccountEventUpdatePressed);
    on<AccountEventUsernameChanged>(_onAccountEventUserNameChange);
    on<AccountEventLogoutPressed>(_onAccountLogoutPressed);
    on<AccountEventStatusChanged>(_onAccountStatusChanged);
  }

  Future<void> _onAccountInfoFetch(
    AccountInfoEventFetch event,
    Emitter<AccountInfoState> emit,
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
          var status = await SharedPreferencesHelper.getStringType(
              SharedPreferencesHelper.keyStatus);
          if (status.isEmpty) {
            status = "Hoạt động";
          }
          emit(state.copyWith(
              status: BlocStatus.success,
              user: user,
              userAfterModify: user,
              userStatus: status));
        } else {
          emit(state.copyWith(status: BlocStatus.error));
        }
      },
      onError: (e) {
        emit(state.copyWith(status: BlocStatus.error));
      },
    );
  }

  Future<void> _onAccountEventAvatarChanged(
    AccountEventAvatarChanged event,
    Emitter<AccountInfoState> emit,
  ) async {
    final bytes = io.File(event.file?.path ?? '').readAsBytesSync();
    String img64 = base64Encode(bytes);
    final currentUserAfterModify = state.userAfterModify;
    final userAfterModify = UserInfoData(
      currentUserAfterModify?.fullName ?? '',
      currentUserAfterModify?.email ?? '',
      img64,
      currentUserAfterModify?.uid ?? '',
      currentUserAfterModify?.status ?? '',
      currentUserAfterModify?.fcmToken ?? '',
      currentUserAfterModify?.isAdmin ?? false,
      currentUserAfterModify?.createdDate?? Timestamp.now(),
    );
    emit(state.copyWith(userAfterModify: userAfterModify));
  }

  Future<void> _onAccountEventUpdatePressed(
    AccountEventUpdatePressed event,
    Emitter<AccountInfoState> emit,
  ) async {
    if (_isValidateSuccess(emit)) {
      await handleCallApi(
        shouldDefaultErrorDialogWhenCallApi: true,
        onNoInternet: (e) {},
        onCallApi: () async {
          emit(state.copyWith(updateStatus: BlocStatus.loading));
          await FireStoreRepository(uid: FirebaseAuth.instance.currentUser!.uid)
              .updateUserdata(
                  state.userAfterModify?.fullName ?? '',
                  state.userAfterModify?.profilePic ?? '',
                  state.userAfterModify?.status ?? 'Hoạt động');

          emit(state.copyWith(
              updateStatus: BlocStatus.success, user: state.userAfterModify));
        },
        onError: (e) {
          emit(state.copyWith(status: BlocStatus.error));
        },
      );
    }
  }

  bool _isValidateSuccess(
    Emitter<AccountInfoState> emit,
  ) {
    if (state.userAfterModify?.fullName.isEmpty ?? true) {
      emit(state.copyWith(isErrorValidateName: true));
      return false;
    } else {
      emit(state.copyWith(isErrorValidateName: false));
    }

    return true;
  }

  Future<void> _onAccountEventUserNameChange(
    AccountEventUsernameChanged event,
    Emitter<AccountInfoState> emit,
  ) async {
    final currentUserAfterModify = state.userAfterModify;
    final userAfterModify = UserInfoData(
      event.username ?? '',
      currentUserAfterModify?.email ?? '',
      currentUserAfterModify?.profilePic ?? '',
      currentUserAfterModify?.uid ?? '',
      currentUserAfterModify?.status ?? '',
      currentUserAfterModify?.fcmToken ?? '',
      currentUserAfterModify?.isAdmin ?? false,
      currentUserAfterModify?.createdDate?? Timestamp.now(),
    );
    emit(state.copyWith(userAfterModify: userAfterModify));
  }

  Future<void> _onAccountLogoutPressed(
    AccountEventLogoutPressed event,
    Emitter<AccountInfoState> emit,
  ) async {
    emit(state.copyWith(logoutStatus: BlocStatus.loading));
    await FirebaseAuth.instance.signOut();
    await SharedPreferencesHelper.setStringType(
        SharedPreferencesHelper.keyEmail, '');
    await SharedPreferencesHelper.setStringType(
        SharedPreferencesHelper.keyStatus, '');
    emit(state.copyWith(logoutStatus: BlocStatus.success));
  }

  Future<void> _onAccountStatusChanged(
    AccountEventStatusChanged event,
    Emitter<AccountInfoState> emit,
  ) async {
    await SharedPreferencesHelper.setStringType(
        SharedPreferencesHelper.keyStatus, event.status ?? "Hoạt động");
    final currentUserAfterModify = state.userAfterModify;
    final userAfterModify = UserInfoData(
      currentUserAfterModify?.fullName ?? '',
      currentUserAfterModify?.email ?? '',
      currentUserAfterModify?.profilePic ?? '',
      currentUserAfterModify?.uid ?? '',
      event.status ?? "Hoạt động",
      currentUserAfterModify?.fcmToken ?? '',
      currentUserAfterModify?.isAdmin ?? false,
      currentUserAfterModify?.createdDate ?? Timestamp.now(),
    );
    emit(state.copyWith(
        userStatus: event.status, userAfterModify: userAfterModify));
  }
}
