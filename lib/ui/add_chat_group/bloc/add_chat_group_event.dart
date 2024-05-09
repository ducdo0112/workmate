import 'package:equatable/equatable.dart';
import 'package:workmate/model/user/user_info_data.dart';

abstract class AddChatGroupEvent extends Equatable {
  const AddChatGroupEvent();
}

class AddChatGroupFetched extends AddChatGroupEvent {
  const AddChatGroupFetched();

  @override
  List<Object?> get props => [];
}

class ChangeUserSelected extends AddChatGroupEvent {
  const ChangeUserSelected({required this.userInfoData, required this.isAdd});

  final UserInfoData userInfoData;
  final bool isAdd;

  @override
  List<Object?> get props => [];
}


class CreateGroupPressed extends AddChatGroupEvent {
  const CreateGroupPressed();

  @override
  List<Object?> get props => [];
}

class CreateGroupPrivateWithUserSelected extends AddChatGroupEvent {
  const CreateGroupPrivateWithUserSelected({required this.userInfoData});
  final UserInfoData userInfoData;

  @override
  List<Object?> get props => [userInfoData];
}

class GroupNameChanged extends AddChatGroupEvent {
  const GroupNameChanged({required this.nameGroup});
  final String nameGroup;

  @override
  List<Object?> get props => [nameGroup];
}
