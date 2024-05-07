// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitHistoryResponse _$VisitHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    VisitHistoryResponse(
      (json['visitHistory'] as List<dynamic>)
          .map((e) => VisitHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['visitStore'] as List<dynamic>)
          .map((e) => NearShop.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_nice'] as bool?,
      json['store_id'] as String?,
    );

Map<String, dynamic> _$VisitHistoryResponseToJson(
        VisitHistoryResponse instance) =>
    <String, dynamic>{
      'visitHistory': instance.visitHistory,
      'visitStore': instance.visitStore,
      'is_nice': instance.isNice,
      'store_id': instance.storeId,
    };

VisitHistory _$VisitHistoryFromJson(Map<String, dynamic> json) => VisitHistory(
      json['datetime'] as String?,
      json['store_name'] as String?,
      json['store_id'] as String?,
      json['store_icon_url'] as String?,
    );

Map<String, dynamic> _$VisitHistoryToJson(VisitHistory instance) =>
    <String, dynamic>{
      'datetime': instance.dateTime,
      'store_name': instance.storeName,
      'store_id': instance.storeId,
      'store_icon_url': instance.storeIconUrl,
    };
