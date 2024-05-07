import 'package:json_annotation/json_annotation.dart';

part 'pref_response.g.dart';

@JsonSerializable()
class PrefResponse {
  @JsonKey(name: "pref")
  final List<Pref> prefs;

  const PrefResponse(this.prefs);


  factory PrefResponse.fromJson(Map<String, dynamic> json) =>
      _$PrefResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrefResponseToJson(this);
}

@JsonSerializable()
class Pref {
  final String? code;
  final String? name;

  const Pref(this.code, this.name);

  factory Pref.fromJson(Map<String, dynamic> json) =>
      _$PrefFromJson(json);

  Map<String, dynamic> toJson() => _$PrefToJson(this);
}


