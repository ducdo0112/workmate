// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgeResponse _$AgeResponseFromJson(Map<String, dynamic> json) => AgeResponse(
      (json['age'] as List<dynamic>)
          .map((e) => Age.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgeResponseToJson(AgeResponse instance) =>
    <String, dynamic>{
      'age': instance.ages,
    };

Age _$AgeFromJson(Map<String, dynamic> json) => Age(
      json['code'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$AgeToJson(Age instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
