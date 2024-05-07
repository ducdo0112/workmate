import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "account_id")
  final String? accountId;
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "is_influencer_popup")
  final bool? isInfluencerPopup;

  const LoginResponse(this.accountId, this.accessToken, this.isInfluencerPopup);

  factory LoginResponse.empty() {
    return const LoginResponse(null, null, null);
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
