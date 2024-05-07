import 'package:json_annotation/json_annotation.dart';

part 'login_status_response.g.dart';

@JsonSerializable()
class LoginStatusResponse {
  @JsonKey(name: "account_id")
  final String? accountId;
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "is_influencer_popup")
  final bool? isInfluencerPopup;

  const LoginStatusResponse(this.accountId, this.accessToken, this.isInfluencerPopup);

  factory LoginStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStatusResponseToJson(this);
}
