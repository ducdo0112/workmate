import 'package:equatable/equatable.dart';
import 'package:workmate/model/user/user_info_data.dart';

import '../../../model/enum/bloc_status.dart';

class PeopleState extends Equatable {
  final List<UserInfoData> users;
  final List<UserInfoData> filteredUsers;

  const PeopleState({required this.users, required this.filteredUsers});

  PeopleState copyWith({
    List<UserInfoData>? users, List<UserInfoData>? filteredUsers,
  }) {
    return PeopleState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
    );
  }

  @override
  List<Object> get props => [users, filteredUsers];
}
