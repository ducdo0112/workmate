import 'package:equatable/equatable.dart';
import 'package:workmate/model/user/user_info_data.dart';

import '../../../model/enum/bloc_status.dart';

class PeopleState extends Equatable {
  final List<UserInfoData> users;
  final bool isAdmin;

  const PeopleState({required this.users, required this.isAdmin});

  PeopleState copyWith({
    List<UserInfoData>? users, bool? isAdmin,
  }) {
    return PeopleState(
      users: users ?? this.users,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object> get props => [users, isAdmin];
}
