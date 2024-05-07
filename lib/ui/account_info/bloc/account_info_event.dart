part of 'account_info_bloc.dart';

abstract class AccountInfoEvent extends Equatable {
  const AccountInfoEvent();
}

class AccountInfoEventFetch extends AccountInfoEvent {
  const AccountInfoEventFetch();

  @override
  List<Object?> get props => [];
}

class AccountEventAvatarChanged extends AccountInfoEvent {
  final XFile? file;

  const AccountEventAvatarChanged({this.file});

  @override
  List<Object?> get props => [file];
}

class AccountEventUsernameChanged extends AccountInfoEvent {
  final String? username;

  const AccountEventUsernameChanged({this.username});

  @override
  List<Object?> get props => [username];
}

class AccountEventStatusChanged extends AccountInfoEvent {
  final String? status;

  const AccountEventStatusChanged({this.status});

  @override
  List<Object?> get props => [status];
}

class AccountEventUpdatePressed extends AccountInfoEvent {

  const AccountEventUpdatePressed();

  @override
  List<Object?> get props => [];
}


class AccountEventLogoutPressed extends AccountInfoEvent {
  const AccountEventLogoutPressed();

  @override
  List<Object?> get props => [];
}
