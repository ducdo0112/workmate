import 'package:equatable/equatable.dart';
import 'package:workmate/model/user/user_info_data.dart';

import '../../../common/bloc/base_state.dart';
import '../../../model/enum/bloc_status.dart';
import '../../../model/http_raw/network_exception.dart';

class PeopleState extends BaseState {
  final Stream? usersStream;
  final bool? isAdmin;

  const PeopleState(
      {BlocStatus status = BlocStatus.initial,
      NetworkException? exception,
      this.usersStream,
      this.isAdmin})
      : super(status: status, exception: exception);

  PeopleState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    Stream? usersStream,
    bool? isAdmin,
  }) {
    return PeopleState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      usersStream: usersStream ?? this.usersStream,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([isAdmin, usersStream]);
}
