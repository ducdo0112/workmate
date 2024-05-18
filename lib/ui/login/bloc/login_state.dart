import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

class LoginState extends BaseState {
  final String email;
  final String password;
  final bool isShowPassword;
  final bool isAdmin;

  // validate
  final bool isErrorInputEmail;
  final bool isErrorInputPassword;

  const LoginState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.email = '',
    this.password = '',
    this.isShowPassword = false,
    this.isAdmin = false,
    this.isErrorInputEmail = false,
    this.isErrorInputPassword = false,
  }) : super(
    status: status,
    exception: exception,
  );

  LoginState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    String? email,
    String? password,
    bool? isShowPassword,
    bool? isAdmin,
    bool? isErrorInputEmail,
    bool? isErrorInputPassword,
  }) =>
      LoginState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        email: email ?? this.email,
        password: password ?? this.password,
        isShowPassword: isShowPassword ?? this.isShowPassword,
        isAdmin: isAdmin ?? this.isAdmin,
        isErrorInputEmail: isErrorInputEmail ?? this.isErrorInputEmail,
        isErrorInputPassword: isErrorInputPassword ?? this.isErrorInputPassword,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      email,
      password,
      isShowPassword,
      isAdmin,
      isErrorInputEmail,
      isErrorInputPassword,
    ]);
}
