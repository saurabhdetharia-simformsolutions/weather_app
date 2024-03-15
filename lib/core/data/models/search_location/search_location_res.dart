import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'search_location_res.g.dart';

SearchLocationRes weatherModelFromJson(String str) =>
    SearchLocationRes.fromJson(json.decode(str));

String weatherModelToJson(SearchLocationRes data) => json.encode(data.toJson());

@JsonSerializable()
class SearchLocationRes {
  @JsonKey(name: "results")
  final List<Result> results;

  SearchLocationRes({
    required this.results,
  });

  SearchLocationRes copyWith({
    List<Result>? results,
  }) =>
      SearchLocationRes(
        results: results ?? this.results,
      );

  factory SearchLocationRes.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationResFromJson(json);

  factory SearchLocationRes.fromCustomJson(Map<String, dynamic> json) {
    if (json.containsKey('results')) {
      return SearchLocationRes.fromJson(json);
    } else {
      return SearchLocationRes(results: []);
    }
  }

  Map<String, dynamic> toJson() => _$SearchLocationResToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "latitude")
  final double latitude;
  @JsonKey(name: "longitude")
  final double longitude;

/*  @JsonKey(name: "elevation")
  final double elevation;*/
/*  @JsonKey(name: "feature_code")
  final String featureCode;*/
  @JsonKey(name: "country_code")
  final String countryCode;

  /* @JsonKey(name: "timezone")
  final String timezone;*/
  @JsonKey(name: "country")
  final String country;

/*  @JsonKey(name: "admin1")
  final String admin1;*/

  Result({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    //required this.elevation,
    // required this.featureCode,
    required this.countryCode,
    //required this.timezone,
    required this.country,
    //required this.admin1,
  });

  Result copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    double? elevation,
    String? featureCode,
    String? countryCode,
    String? timezone,
    String? country,
    String? admin1,
    String? admin2,
  }) =>
      Result(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        //elevation: elevation ?? this.elevation,
        //featureCode: featureCode ?? this.featureCode,
        countryCode: countryCode ?? this.countryCode,
        //timezone: timezone ?? this.timezone,
        country: country ?? this.country,
        //admin1: admin1 ?? this.admin1,
      );

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
