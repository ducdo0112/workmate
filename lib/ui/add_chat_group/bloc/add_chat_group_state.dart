import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

import '../../../model/user/user_info_data.dart';

class AddChatGroupState extends BaseState {
  final List<UserInfoData>? listUsers;
  final List<UserInfoData>? listUsersSelected;
  final bool shouldShowErrorInputNameGroup;
  final bool shouldShowErrorSelectUser;
  final String groupName;
  final String groupId;
  final String avatarAdmin;
  final String emailAdmin;
  final String usernameAdmin;

  final BlocStatus statusCreateGroup;
  final BlocStatus statusCreatePrivateGroup;

  const AddChatGroupState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.listUsers,
    this.listUsersSelected = const [],
    this.shouldShowErrorInputNameGroup = false,
    this.shouldShowErrorSelectUser = false,
    this.groupName = '',
    this.groupId = '',
    this.avatarAdmin = '',
    this.emailAdmin = '',
    this.usernameAdmin = '',
    this.statusCreateGroup = BlocStatus.initial,
    this.statusCreatePrivateGroup = BlocStatus.initial,
  }) : super(status: status, exception: exception);

  AddChatGroupState copyWith({
    BlocStatus? status,
    BlocStatus? statusCreateGroup,
    BlocStatus? statusCreatePrivateGroup,
    NetworkException? exception,
    List<UserInfoData>? listUsers,
    List<UserInfoData>? listUsersSelected,
    bool? shouldShowErrorInputNameGroup,
    bool? shouldShowErrorSelectUser,
    String? groupName,
    String? groupId,
    String? avatarAdmin,
    String? emailAdmin,
    String? usernameAdmin,
  }) =>
      AddChatGroupState(
        status: status ?? this.status,
        statusCreateGroup: statusCreateGroup ?? this.statusCreateGroup,
        statusCreatePrivateGroup: statusCreatePrivateGroup ?? this.statusCreatePrivateGroup,
        exception: exception ?? this.exception,
        listUsers: listUsers ?? this.listUsers,
        listUsersSelected: listUsersSelected ?? this.listUsersSelected,
        shouldShowErrorInputNameGroup:
            shouldShowErrorInputNameGroup ?? this.shouldShowErrorInputNameGroup,
        shouldShowErrorSelectUser:
            shouldShowErrorSelectUser ?? this.shouldShowErrorSelectUser,
        groupName: groupName ?? this.groupName,
        groupId: groupId ?? this.groupId,
        avatarAdmin: avatarAdmin ?? this.avatarAdmin,
        emailAdmin: emailAdmin ?? this.emailAdmin,
        usernameAdmin: usernameAdmin ?? this.usernameAdmin,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      listUsers,
      listUsersSelected,
      shouldShowErrorSelectUser,
      shouldShowErrorInputNameGroup,
      groupName,
      groupId,
      avatarAdmin,
      emailAdmin,
      usernameAdmin,
      statusCreateGroup,
      statusCreatePrivateGroup
    ]);
}