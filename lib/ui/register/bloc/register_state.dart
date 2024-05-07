import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/age_response/age_response.dart';
import 'package:workmate/model/city_response/city_response.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/enum/sex.dart';
import 'package:workmate/model/http_raw/network_exception.dart';
import 'package:workmate/model/pref_response/pref_response.dart';
import 'package:workmate/model/register_user_code_response/register_user_code_response.dart';

class RegisterState extends BaseState {
  final String username;
  final String email;
  final String password;
  final bool showPassword;

  // validate state
  final bool isErrorInputUsername;
  final bool isErrorInputEmail;
  final bool isErrorInputPassword;

  const RegisterState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.username = '',
    this.password = '',
    this.email = '',
    this.showPassword = false,
    this.isErrorInputUsername = false,
    this.isErrorInputEmail = false,
    this.isErrorInputPassword = false,
  }) : super(
          status: status,
          exception: exception,
        );

  RegisterState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    String? username,
    String? password,
    String? email,
    bool? showPassword,
    bool? isErrorInputUsername,
    bool? isErrorInputEmail,
    bool? isErrorInputPassword,
  }) =>
      RegisterState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        password: password ?? this.password,
        username: username ?? this.username,
        email: email ?? this.email,
        showPassword: showPassword ?? this.showPassword,
        isErrorInputUsername: isErrorInputUsername ?? this.isErrorInputUsername,
        isErrorInputEmail: isErrorInputEmail ?? this.isErrorInputEmail,
        isErrorInputPassword: isErrorInputPassword ?? this.isErrorInputPassword,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      username,
      password,
      email,
      showPassword,
      isErrorInputUsername,
      isErrorInputEmail,
      isErrorInputPassword,
    ]);
}
