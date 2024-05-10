// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      userName: json['userName'] as String?,
      groupId: json['groupId'] as String,
      groupName: json['groupName'] as String,
      isPrivateGroup: json['isPrivateGroup'] as bool,
      username1: json['username1'] as String?,
      username2: json['username2'] as String?,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'userName': instance.userName,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'isPrivateGroup': instance.isPrivateGroup,
      'username1': instance.username1,
      'username2': instance.username2,
    };
