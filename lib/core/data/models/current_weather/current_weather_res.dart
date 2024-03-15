import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'current_weather_res.g.dart';

@JsonSerializable()
class CurrentWeatherRes {
  @JsonKey(name: "coord")
  final Coord? coord;
  @JsonKey(name: "weather")
  final List<Weather>? weather;
  @JsonKey(name: "base")
  final String? base;
  @JsonKey(name: "main")
  final Main? main;
  @JsonKey(name: "visibility")
  final int? visibility;
  @JsonKey(name: "wind")
  final Wind? wind;
  @JsonKey(name: "clouds")
  final Clouds? clouds;
  @JsonKey(name: "dt")
  final int? dt;
  @JsonKey(name: "sys")
  final Sys? sys;
  @JsonKey(name: "timezone")
  final int? timezone;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "cod")
  final int? cod;

  CurrentWeatherRes({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  CurrentWeatherRes copyWith({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) =>
      CurrentWeatherRes(
        coord: coord ?? this.coord,
        weather: weather ?? this.weather,
        base: base ?? this.base,
        main: main ?? this.main,
        visibility: visibility ?? this.visibility,
        wind: wind ?? this.wind,
        clouds: clouds ?? this.clouds,
        dt: dt ?? this.dt,
        sys: sys ?? this.sys,
        timezone: timezone ?? this.timezone,
        id: id ?? this.id,
        name: name ?? this.name,
        cod: cod ?? this.cod,
      );

  factory CurrentWeatherRes.fromJson(Map<String, dynamic> json) => _$CurrentWeatherResFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherResToJson(this);
}

@JsonSerializable()
class Clouds {
  @JsonKey(name: "all")
  final int? all;

  Clouds({
    this.all,
  });

  Clouds copyWith({
    int? all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Coord {
  @JsonKey(name: "lon")
  final double? lon;
  @JsonKey(name: "lat")
  final double? lat;

  Coord({
    this.lon,
    this.lat,
  });

  Coord copyWith({
    double? lon,
    double? lat,
  }) =>
      Coord(
        lon: lon ?? this.lon,
        lat: lat ?? this.lat,
      );

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Main {
  @JsonKey(name: "temp")
  final double? temp;
  @JsonKey(name: "feels_like")
  final double? feelsLike;
  @JsonKey(name: "temp_min")
  final double? tempMin;
  @JsonKey(name: "temp_max")
  final double? tempMax;
  @JsonKey(name: "pressure")
  final int? pressure;
  @JsonKey(name: "humidity")
  final int? humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
      );

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Sys {
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @JsonKey(name: "sunset")
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) =>
      Sys(
        type: type ?? this.type,
        id: id ?? this.id,
        country: country ?? this.country,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
class Weather {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "main")
  final String? main;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "icon")
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Wind {
  @JsonKey(name: "speed")
  final double? speed;
  @JsonKey(name: "deg")
  final int? deg;

  Wind({
    this.speed,
    this.deg,
  });

  Wind copyWith({
    double? speed,
    int? deg,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
      );

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}