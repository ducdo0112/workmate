import 'package:json_annotation/json_annotation.dart';

part 'register_user_code_response.g.dart';

@JsonSerializable()
class RegisterUserCodeResponse {
  @JsonKey(name: "dummy_account_id")
  final String? dummyAccountId;

  const RegisterUserCodeResponse(this.dummyAccountId);

  factory RegisterUserCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserCodeResponseToJson(this);
}
