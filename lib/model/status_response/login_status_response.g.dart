// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginStatusResponse _$LoginStatusResponseFromJson(Map<String, dynamic> json) =>
    LoginStatusResponse(
      json['account_id'] as String?,
      json['access_token'] as String?,
      json['is_influencer_popup'] as bool?,
    );

Map<String, dynamic> _$LoginStatusResponseToJson(
        LoginStatusResponse instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'access_token': instance.accessToken,
      'is_influencer_popup': instance.isInfluencerPopup,
    };
