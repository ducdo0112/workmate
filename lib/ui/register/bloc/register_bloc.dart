import 'package:workmate/common/bloc/call_api.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/enum/register_step.dart';
import 'package:workmate/model/enum/sex.dart';
import 'package:workmate/repository/auth_repository.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/repository/shared_preferences_repository.dart';
import 'package:workmate/ui/register/bloc/register_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/firebase/firebase_remote_message_service.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final regExpEmailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RegisterBloc({required this.authRepository}) : super(const RegisterState()) {
    on<RegisterEventPasswordChanged>(_onPassWordChanged);
    on<RegisterEmailEventChanged>(_onEmailChanged);
    on<RegisterUserNameEventChanged>(_onUsernameChanged);
    on<RegisterButtonPressed>(_onButtonRegisterPressed);
    on<RegisterHideTextPasswordEventPressed>(_onShowHidePasswordChanged);
  }

  void _onPassWordChanged(
    RegisterEventPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onEmailChanged(
    RegisterEmailEventChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onUsernameChanged(
    RegisterUserNameEventChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(username: event.userName));
  }

  void _onShowHidePasswordChanged(
    RegisterHideTextPasswordEventPressed event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(showPassword: !(state.showPassword)));
  }

  Future<void> _onButtonRegisterPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    if (_isValidateSuccessInput(emit)) {
      await handleCallApi(
        shouldDefaultErrorDialogWhenCallApi: true,
        onCallApi: () async {
          emit(state.copyWith(status: BlocStatus.loading));

          final userCredential = await authRepository.registerAccount(
              username: state.username,
              email: state.email,
              password: state.password);

          if (userCredential != null) {

            //call data base to update the date
            await FireStoreRepository(uid: userCredential.user?.uid).savingUserdata(state.username, state.email);
            await SharedPreferencesHelper.setStringType(SharedPreferencesHelper.keyEmail, state.email);
            await FirebaseRemoteMessageService()
                .updateFcmTokenOnServerAfterLoginOrRegister(
                userCredential.user?.uid ?? '');
            emit(state.copyWith(status: BlocStatus.success));
          } else {
            emit(state.copyWith(status: BlocStatus.error));
          }
        },
        onError: (e) {
          emit(state.copyWith(status: BlocStatus.error));
        },
      );
    }
  }

  bool _isValidateSuccessInput(Emitter<RegisterState> emit) {
    // username
    bool resultValidateUsernameInput = true;
    if (state.username.isEmpty) {
      resultValidateUsernameInput = false;
    }

    // email
    bool resultValidateEmailInput = true;
    if (state.email.isEmpty ||
        !regExpEmailValidate.hasMatch(state.email)) {
      resultValidateEmailInput = false;
    }

    // username
    bool resultValidatePasswordInput = true;
    if (state.password.isEmpty || state.password.length < 6) {
      resultValidatePasswordInput = false;
    }

    emit(state.copyWith(
      isErrorInputUsername: !resultValidateUsernameInput,
      isErrorInputPassword: !resultValidatePasswordInput,
      isErrorInputEmail: !resultValidateEmailInput,
    ));

    if (!resultValidatePasswordInput ||
        !resultValidateEmailInput ||
        !resultValidateUsernameInput) {
      return false;
    }

    return true;
  }
}
