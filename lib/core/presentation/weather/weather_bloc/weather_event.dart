part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeatherDetailsEvent extends WeatherEvent {
  final String? name;
  final String? latitude;
  final String? longitude;

  GetWeatherDetailsEvent({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class SearchLocationEvent extends WeatherEvent {
  final String location;

  SearchLocationEvent({required this.location});
}

class WeatherTempConvertEvent extends WeatherEvent {
  final CurrentWeatherRes weatherDetailsResponse;

  WeatherTempConvertEvent({required this.weatherDetailsResponse});
}