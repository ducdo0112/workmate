import 'package:json_annotation/json_annotation.dart';

part 'account_info_response.g.dart';

@JsonSerializable()
class AccountInfoResponse {
  @JsonKey(name: "account_json")
  final AccountInfo accountInfo;

  const AccountInfoResponse(this.accountInfo);

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoResponseToJson(this);
}

@JsonSerializable()
class AccountInfo {
  @JsonKey(name: "nickname")
  final String? nickname;
  @JsonKey(name: "age")
  final String? age;
  @JsonKey(name: "sex")
  final String? sex;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "pref_name")
  final String? prefName;
  @JsonKey(name: "city_name")
  final String? cityName;
  @JsonKey(name: "referrer_code")
  final String? referrerCode;
  @JsonKey(name: "update_dt")
  final String? updateDt;

  const AccountInfo(this.nickname, this.age, this.sex, this.address,
      this.prefName, this.cityName, this.referrerCode, this.updateDt);

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}
