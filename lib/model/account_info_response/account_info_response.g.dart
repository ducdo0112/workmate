// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      AccountInfo.fromJson(json['account_json'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountInfoResponseToJson(
        AccountInfoResponse instance) =>
    <String, dynamic>{
      'account_json': instance.accountInfo,
    };

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) => AccountInfo(
      json['nickname'] as String?,
      json['age'] as String?,
      json['sex'] as String?,
      json['address'] as String?,
      json['pref_name'] as String?,
      json['city_name'] as String?,
      json['referrer_code'] as String?,
      json['update_dt'] as String?,
    );

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'age': instance.age,
      'sex': instance.sex,
      'address': instance.address,
      'pref_name': instance.prefName,
      'city_name': instance.cityName,
      'referrer_code': instance.referrerCode,
      'update_dt': instance.updateDt,
    };
