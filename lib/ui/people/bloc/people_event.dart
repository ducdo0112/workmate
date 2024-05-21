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

class PeopleEventSearch extends PeopleEvent {
  final String query;

  const PeopleEventSearch({required this.query});

  @override
  List<Object?> get props => [query];
}
