import 'package:workmate/model/near_shop/near_shop_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_history_response.g.dart';

@JsonSerializable()
class VisitHistoryResponse {
  final List<VisitHistory> visitHistory;
  final List<NearShop> visitStore;
  @JsonKey(name: "is_nice")
  final bool? isNice;
  @JsonKey(name: "store_id")
  final String? storeId;

  const VisitHistoryResponse(
      this.visitHistory, this.visitStore, this.isNice, this.storeId);

  factory VisitHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitHistoryResponseToJson(this);
}

@JsonSerializable()
class VisitHistory {
  @JsonKey(name: "datetime")
  final String? dateTime;
  @JsonKey(name: "store_name")
  final String? storeName;
  @JsonKey(name: "store_id")
  final String? storeId;
  @JsonKey(name: "store_icon_url")
  final String? storeIconUrl;

  const VisitHistory(
      this.dateTime, this.storeName, this.storeId, this.storeIconUrl);

  factory VisitHistory.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$VisitHistoryToJson(this);
}
