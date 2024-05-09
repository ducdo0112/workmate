import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

import '../../../model/group/group.dart';

class ChatState extends BaseState {
  final List<Group> groups;
  const ChatState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.groups = const [],
  }) : super(status: status, exception: exception);

  ChatState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    List<Group>? groups,
  }) =>
      ChatState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        groups: groups ?? this.groups,
      );

  @override
  List<Object?> get props => super.props..addAll([groups]);
}
