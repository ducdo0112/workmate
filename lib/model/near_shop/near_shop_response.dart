import 'package:json_annotation/json_annotation.dart';

part 'near_shop_response.g.dart';

@JsonSerializable()
class NearShopListResponse {
  @JsonKey(name: "near_store")
  final List<NearShop>? nearShopList;

  const NearShopListResponse(this.nearShopList);

  factory NearShopListResponse.fromJson(Map<String, dynamic> json) =>
      _$NearShopListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearShopListResponseToJson(this);
}

@JsonSerializable()
class NearShop {
  @JsonKey(name: "store_id")
  final String? id;
  @JsonKey(name: "store_name")
  final String? storeName;
  @JsonKey(name: "store_icon_url")
  final String? storeIconUrl;

  const NearShop(this.id, this.storeName, this.storeIconUrl);

  factory NearShop.fromJson(Map<String, dynamic> json) =>
      _$NearShopFromJson(json);

  Map<String, dynamic> toJson() => _$NearShopToJson(this);
}
