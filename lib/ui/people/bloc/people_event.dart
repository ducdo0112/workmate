import 'package:equatable/equatable.dart';
import 'package:workmate/model/user/user_info_data.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class PeopleEventInitFetched extends PeopleEvent {
  const PeopleEventInitFetched();

  @override
  List<Object> get props => [];
}

class PeopleEventDeleteUser extends PeopleEvent {
  final String uuid;

  const PeopleEventDeleteUser({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}
