// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$GroupFromJson(Map<String, dynamic> json) => Conversation(
      userName: json['userName'] as String?,
      conversationId: json['conversationId'] as String,
      conversationName: json['conversationName'] as String,
      isPrivateConversation: json['isPrivateConversation'] as bool,
      username1: json['username1'] as String?,
      username2: json['username2'] as String?,
    );

Map<String, dynamic> _$GroupToJson(Conversation instance) => <String, dynamic>{
      'userName': instance.userName,
      'groupId': instance.conversationId,
      'groupName': instance.conversationName,
      'isPrivateGroup': instance.isPrivateConversation,
      'username1': instance.username1,
      'username2': instance.username2,
    };
