// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'influencer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfluencerResponse _$InfluencerResponseFromJson(Map<String, dynamic> json) =>
    InfluencerResponse(
      (json['influencer'] as List<dynamic>)
          .map((e) => Influencer.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['store_image_url'] as String?,
      json['store_name'] as String?,
      json['store_address'] as String?,
    );

Map<String, dynamic> _$InfluencerResponseToJson(InfluencerResponse instance) =>
    <String, dynamic>{
      'influencer': instance.listInfluencer,
      'store_image_url': instance.storeImageUrl,
      'store_name': instance.storeName,
      'store_address': instance.storeAddress,
    };

Influencer _$InfluencerFromJson(Map<String, dynamic> json) => Influencer(
      json['influencer_id'] as String?,
      json['influencer_name'] as String?,
      json['profile_url'] as String?,
      json['profile'] as String?,
      json['icon_url'] as String?,
    );

Map<String, dynamic> _$InfluencerToJson(Influencer instance) =>
    <String, dynamic>{
      'influencer_id': instance.id,
      'influencer_name': instance.influencerName,
      'profile_url': instance.profileUrl,
      'profile': instance.profile,
      'icon_url': instance.iconUrl,
    };
