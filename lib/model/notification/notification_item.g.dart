// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['body'] as String,
      (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      json['eventId'] as String,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'eventId': instance.eventId,
      'users': instance.users,
    };
