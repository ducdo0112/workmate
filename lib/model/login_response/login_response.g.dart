// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['account_id'] as String?,
      json['access_token'] as String?,
      json['is_influencer_popup'] as bool?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'access_token': instance.accessToken,
      'is_influencer_popup': instance.isInfluencerPopup,
    };
