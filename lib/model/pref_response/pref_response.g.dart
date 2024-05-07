// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrefResponse _$PrefResponseFromJson(Map<String, dynamic> json) => PrefResponse(
      (json['pref'] as List<dynamic>)
          .map((e) => Pref.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrefResponseToJson(PrefResponse instance) =>
    <String, dynamic>{
      'pref': instance.prefs,
    };

Pref _$PrefFromJson(Map<String, dynamic> json) => Pref(
      json['code'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$PrefToJson(Pref instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
