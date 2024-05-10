// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) => UserInfoData(
      json['fullName'] as String,
      json['email'] as String,
      json['profilePic'] as String,
      json['uid'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'profilePic': instance.profilePic,
      'uid': instance.uid,
      'status': instance.status,
    };
