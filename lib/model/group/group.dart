import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String? userName;
  final String groupId;
  final String groupName;
  final bool isPrivateGroup;
  final String? username1;
  final String? username2;

  const Group({this.userName,required this.groupId,required this.groupName, required this.isPrivateGroup, this.username1, this.username2});

  factory Group.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}