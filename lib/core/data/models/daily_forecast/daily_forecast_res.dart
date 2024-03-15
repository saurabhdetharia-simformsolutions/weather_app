import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'daily_forecast_res.g.dart';

DailyForecast dailyForecastFromJson(String str) => DailyForecast.fromJson(json.decode(str));

String dailyForecastToJson(DailyForecast data) => json.encode(data.toJson());

@JsonSerializable()
class DailyForecast {
  @JsonKey(name: "city")
  City? city;
  @JsonKey(name: "cod")
  String? cod;
  @JsonKey(name: "message")
  double? message;
  @JsonKey(name: "cnt")
  int? cnt;
  @JsonKey(name: "list")
  List<ListElement>? list;

  DailyForecast({
    this.city,
    this.cod,
    this.message,
    this.cnt,
    this.list,
  });

  DailyForecast copyWith({
    City? city,
    String? cod,
    double? message,
    int? cnt,
    List<ListElement>? list,
  }) =>
      DailyForecast(
        city: city ?? this.city,
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        list: list ?? this.list,
      );

  factory DailyForecast.fromJson(Map<String, dynamic> json) => _$DailyForecastFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "coord")
  Coord? coord;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "population")
  int? population;
  @JsonKey(name: "timezone")
  int? timezone;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
  });

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        coord: coord ?? this.coord,
        country: country ?? this.country,
        population: population ?? this.population,
        timezone: timezone ?? this.timezone,
      );

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class Coord {
  @JsonKey(name: "lon")
  double? lon;
  @JsonKey(name: "lat")
  double? lat;

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
class ListElement {
  @JsonKey(name: "dt")
  int? dt;
  @JsonKey(name: "sunrise")
  int? sunrise;
  @JsonKey(name: "sunset")
  int? sunset;
  @JsonKey(name: "temp")
  Temp? temp;
  @JsonKey(name: "feels_like")
  FeelsLike? feelsLike;
  @JsonKey(name: "pressure")
  int? pressure;
  @JsonKey(name: "humidity")
  int? humidity;
  @JsonKey(name: "weather")
  List<Weather>? weather;
  @JsonKey(name: "speed")
  double? speed;
  @JsonKey(name: "deg")
  int? deg;
  @JsonKey(name: "gust")
  double? gust;
  @JsonKey(name: "clouds")
  int? clouds;
  @JsonKey(name: "pop")
  double? pop;
  @JsonKey(name: "rain")
  double? rain;

  ListElement({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.weather,
    this.speed,
    this.deg,
    this.gust,
    this.clouds,
    this.pop,
    this.rain,
  });

  ListElement copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    Temp? temp,
    FeelsLike? feelsLike,
    int? pressure,
    int? humidity,
    List<Weather>? weather,
    double? speed,
    int? deg,
    double? gust,
    int? clouds,
    double? pop,
    double? rain,
  }) =>
      ListElement(
        dt: dt ?? this.dt,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        weather: weather ?? this.weather,
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
        clouds: clouds ?? this.clouds,
        pop: pop ?? this.pop,
        rain: rain ?? this.rain,
      );

  factory ListElement.fromJson(Map<String, dynamic> json) => _$ListElementFromJson(json);

  Map<String, dynamic> toJson() => _$ListElementToJson(this);
}

@JsonSerializable()
class FeelsLike {
  @JsonKey(name: "day")
  double? day;
  @JsonKey(name: "night")
  double? night;
  @JsonKey(name: "eve")
  double? eve;
  @JsonKey(name: "morn")
  double? morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  FeelsLike copyWith({
    double? day,
    double? night,
    double? eve,
    double? morn,
  }) =>
      FeelsLike(
        day: day ?? this.day,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory FeelsLike.fromJson(Map<String, dynamic> json) => _$FeelsLikeFromJson(json);

  Map<String, dynamic> toJson() => _$FeelsLikeToJson(this);
}

@JsonSerializable()
class Temp {
  @JsonKey(name: "day")
  double? day;
  @JsonKey(name: "min")
  double? min;
  @JsonKey(name: "max")
  double? max;
  @JsonKey(name: "night")
  double? night;
  @JsonKey(name: "eve")
  double? eve;
  @JsonKey(name: "morn")
  double? morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp copyWith({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) =>
      Temp(
        day: day ?? this.day,
        min: min ?? this.min,
        max: max ?? this.max,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);

  Map<String, dynamic> toJson() => _$TempToJson(this);
}

@JsonSerializable()
class Weather {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "main")
  String? main;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "icon")
  String? icon;

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

