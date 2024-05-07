import 'package:json_annotation/json_annotation.dart';

part 'age_response.g.dart';

@JsonSerializable()
class AgeResponse {
  @JsonKey(name: "age")
  final List<Age> ages;

  const AgeResponse(this.ages);


  factory AgeResponse.fromJson(Map<String, dynamic> json) =>
      _$AgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgeResponseToJson(this);
}

@JsonSerializable()
class Age {
  final String? code;
  final String? name;

  const Age(this.code, this.name);

  factory Age.fromJson(Map<String, dynamic> json) =>
      _$AgeFromJson(json);

  Map<String, dynamic> toJson() => _$AgeToJson(this);
}


