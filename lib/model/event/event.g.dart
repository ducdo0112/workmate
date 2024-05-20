// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['id'] as String?,
      json['title'] as String?,
      json['note'] as String?,
      json['hourStart'] as String?,
      json['hourEnd'] as String?,
      json['dateTime'] as String?,
      json['tag'] as String?,
      (json['typeOfRemind'] as num?)?.toInt(),
      json['uuidAdmin'] as String?,
      (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['urlPdfFile'] as String?,
      json['fileName'] as String?,
      (json['notificationId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'hourStart': instance.hourStart,
      'hourEnd': instance.hourEnd,
      'dateTime': instance.dateTime,
      'tag': instance.tag,
      'typeOfRemind': instance.typeOfRemind,
      'users': instance.users,
      'uuidAdmin': instance.uuidAdmin,
      'urlPdfFile': instance.urlPdfFile,
      'fileName': instance.fileName,
      'notificationId': instance.notificationId,
    };
