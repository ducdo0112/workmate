import 'package:workmate/common/bloc/call_api.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/repository/auth_repository.dart';
import 'package:workmate/service/firebase/firebase_remote_message_service.dart';
import 'package:workmate/ui/login/bloc/login_event.dart';
import 'package:workmate/ui/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/shared_preferences_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final regExpEmailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginEventEmailChanged>(_onEmailChanged);
    on<LoginEventPasswordChanged>(_onPasswordChanged);
    on<LoginEventPressed>(_onLoginPressed);
    on<LoginEventShowHidePassChanged>(_onShowHidePassChanged);
  }

  void _onShowHidePassChanged(
    LoginEventShowHidePassChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }

  void _onEmailChanged(
    LoginEventEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  void _onPasswordChanged(
    LoginEventPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  Future<void> _onLoginPressed(
    LoginEventPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (!_isValidateSuccessInput(emit)) {
      return;
    }
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        emit(state.copyWith(status: BlocStatus.loading));
        final loginCredential = await authRepository.login(
          email: state.email,
          password: state.password,
        );

        if (loginCredential != null) {
          emit(state.copyWith(status: BlocStatus.success));
          await SharedPreferencesHelper.setStringType(
              SharedPreferencesHelper.keyEmail, state.email);
          await FirebaseRemoteMessageService()
              .updateFcmTokenOnServerAfterLoginOrRegister(
                  loginCredential.user?.uid ?? '');
        } else {
          emit(state.copyWith(status: BlocStatus.error));
        }
      },
      onError: (e) {
        emit(state.copyWith(status: BlocStatus.error));
      },
    );
  }

  bool _isValidateSuccessInput(Emitter<LoginState> emit) {
    // email
    bool resultValidateEmailInput = true;
    if (state.email.isEmpty || !regExpEmailValidate.hasMatch(state.email)) {
      resultValidateEmailInput = false;
    }

    // username
    bool resultValidatePasswordInput = true;
    if (state.password.isEmpty) {
      resultValidatePasswordInput = false;
    }

    emit(state.copyWith(
      isErrorInputPassword: !resultValidatePasswordInput,
      isErrorInputEmail: !resultValidateEmailInput,
    ));

    if (!resultValidatePasswordInput || !resultValidateEmailInput) {
      return false;
    }

    return true;
  }
}
