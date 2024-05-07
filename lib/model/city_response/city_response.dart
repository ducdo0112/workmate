import 'package:json_annotation/json_annotation.dart';

part 'city_response.g.dart';

@JsonSerializable()
class CityResponse {
  @JsonKey(name: "city")
  final List<City> citys;

  const CityResponse(this.citys);


  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}

@JsonSerializable()
class City {
  final String? code;
  final String? name;

  const City(this.code, this.name);

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}


