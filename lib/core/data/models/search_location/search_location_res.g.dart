// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationRes _$SearchLocationResFromJson(Map<String, dynamic> json) =>
    SearchLocationRes(
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchLocationResToJson(SearchLocationRes instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      countryCode: json['country_code'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country_code': instance.countryCode,
      'country': instance.country,
    };
