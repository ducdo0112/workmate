// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_shop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearShopListResponse _$NearShopListResponseFromJson(
        Map<String, dynamic> json) =>
    NearShopListResponse(
      (json['near_store'] as List<dynamic>?)
          ?.map((e) => NearShop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NearShopListResponseToJson(
        NearShopListResponse instance) =>
    <String, dynamic>{
      'near_store': instance.nearShopList,
    };

NearShop _$NearShopFromJson(Map<String, dynamic> json) => NearShop(
      json['store_id'] as String?,
      json['store_name'] as String?,
      json['store_icon_url'] as String?,
    );

Map<String, dynamic> _$NearShopToJson(NearShop instance) => <String, dynamic>{
      'store_id': instance.id,
      'store_name': instance.storeName,
      'store_icon_url': instance.storeIconUrl,
    };
