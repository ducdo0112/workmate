import 'dart:ffi';

import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

import '../../../model/user/user_info_data.dart';

class AddChatGroupState extends BaseState {
  final List<UserInfoData>? listUsers;
  final List<UserInfoData>? listUsersSelected;
  final bool shouldShowErrorInputNameGroup;
  final bool shouldShowErrorSelectUser;
  final String conversationName;
  final String conversationId;
  final String avatarAdmin;
  final String emailAdmin;
  final String usernameAdmin;
  final bool isAdmin;

  final BlocStatus statusCreateGroup;
  final BlocStatus statusCreatePrivateGroup;

  final String username1;
  final String username2;
  final String avatarUser1;
  final String avatarUser2;
  final bool isPrivateConversation;

  final String emailUser1;
  final String emailUser2;

  const AddChatGroupState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.listUsers,
    this.listUsersSelected = const [],
    this.shouldShowErrorInputNameGroup = false,
    this.shouldShowErrorSelectUser = false,
    this.conversationName = '',
    this.conversationId = '',
    this.avatarAdmin = '',
    this.emailAdmin = '',
    this.usernameAdmin = '',
    this.statusCreateGroup = BlocStatus.initial,
    this.statusCreatePrivateGroup = BlocStatus.initial,
    this.username1 = '',
    this.username2 = '',
    this.avatarUser1 = '',
    this.avatarUser2 = '',
    this.emailUser1 = '',
    this.emailUser2 = '',
    this.isPrivateConversation = false,
    this.isAdmin = false,
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
    String? conversationName,
    String? conversationId,
    String? avatarAdmin,
    String? emailAdmin,
    String? usernameAdmin,
    String? username1,
    String? username2,
    String? avatarUser1,
    String? avatarUser2,
    String? emailUser1,
    String? emailUser2,
    bool? isPrivateConversation,
    bool? isAdmin,
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
        conversationName: conversationName ?? this.conversationName,
        conversationId: conversationId ?? this.conversationId,
        avatarAdmin: avatarAdmin ?? this.avatarAdmin,
        emailAdmin: emailAdmin ?? this.emailAdmin,
        usernameAdmin: usernameAdmin ?? this.usernameAdmin,
        username1: username1 ?? this.username1,
        username2: username2 ?? this.username2,
        isPrivateConversation: isPrivateConversation ?? this.isPrivateConversation,
        isAdmin: isAdmin ?? this.isAdmin,
        avatarUser1: avatarUser1 ?? this.avatarUser1,
        avatarUser2: avatarUser2 ?? this.avatarUser2,
        emailUser1: emailUser1 ?? this.emailUser1,
        emailUser2: emailUser2 ?? this.emailUser2,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      listUsers,
      listUsersSelected,
      shouldShowErrorSelectUser,
      shouldShowErrorInputNameGroup,
      conversationName,
      conversationId,
      avatarAdmin,
      emailAdmin,
      usernameAdmin,
      statusCreateGroup,
      statusCreatePrivateGroup,
      username1,
      username2,
      isPrivateConversation,
      isAdmin,
      avatarUser2,
      avatarUser1,
      emailUser1,
      emailUser2,
    ]);
}
