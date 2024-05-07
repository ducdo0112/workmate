part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterEventPasswordChanged extends RegisterEvent {
  final String? password;

  const RegisterEventPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class RegisterUserNameEventChanged extends RegisterEvent {
  final String? userName;

  const RegisterUserNameEventChanged({this.userName});

  @override
  List<Object?> get props => [userName];
}

class RegisterEmailEventChanged extends RegisterEvent {
  final String? email;

  const RegisterEmailEventChanged({this.email});

  @override
  List<Object?> get props => [email];
}



class RegisterHideTextPasswordEventPressed extends RegisterEvent {
  const RegisterHideTextPasswordEventPressed();

  @override
  List<Object?> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  const RegisterButtonPressed();

  @override
  List<Object?> get props => [];
}
