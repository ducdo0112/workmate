import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEventEmailChanged extends LoginEvent {
  final String? email;

  const LoginEventEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class LoginEventPasswordChanged extends LoginEvent {
  final String? password;

  const LoginEventPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class LoginEventShowHidePassChanged extends LoginEvent {
  const LoginEventShowHidePassChanged();

  @override
  List<Object?> get props => [];
}

class LoginEventPressed extends LoginEvent {
  const LoginEventPressed();

  @override
  List<Object?> get props => [];
}
