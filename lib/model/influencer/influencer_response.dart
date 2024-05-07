import 'package:json_annotation/json_annotation.dart';

part 'influencer_response.g.dart';

@JsonSerializable()
class InfluencerResponse {
  @JsonKey(name: "influencer")
  final List<Influencer> listInfluencer;
  @JsonKey(name: "store_image_url")
  final String? storeImageUrl;
  @JsonKey(name: "store_name")
  final String? storeName;
  @JsonKey(name: "store_address")
  final String? storeAddress;

  const InfluencerResponse(this.listInfluencer, this.storeImageUrl,
      this.storeName, this.storeAddress);

  factory InfluencerResponse.fromJson(Map<String, dynamic> json) =>
      _$InfluencerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InfluencerResponseToJson(this);
}

@JsonSerializable()
class Influencer {
  @JsonKey(name: "influencer_id")
  final String? id;
  @JsonKey(name: "influencer_name")
  final String? influencerName;
  @JsonKey(name: "profile_url")
  final String? profileUrl;
  @JsonKey(name: "profile")
  final String? profile;
  @JsonKey(name: "icon_url")
  final String? iconUrl;

  const Influencer(this.id, this.influencerName, this.profileUrl, this.profile,
      this.iconUrl);

  factory Influencer.fromJson(Map<String, dynamic> json) =>
      _$InfluencerFromJson(json);

  Map<String, dynamic> toJson() => _$InfluencerToJson(this);
}
