import 'package:equatable/equatable.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class PeopleEventInitFetched extends PeopleEvent {
  final DateTime? dateTime;
  const PeopleEventInitFetched(this.dateTime);

  @override
  List<Object?> get props => [];
}

class PeopleChangeStateRebuildAppbar extends PeopleEvent {
  final bool needRebuildAppBar;
  const PeopleChangeStateRebuildAppbar(this.needRebuildAppBar);

  @override
  List<Object?> get props => [needRebuildAppBar];
}

