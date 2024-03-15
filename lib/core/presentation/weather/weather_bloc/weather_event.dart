part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeatherDetailsEvent extends WeatherEvent {
  final String latitude;
  final String longitude;

  GetWeatherDetailsEvent({required this.latitude, required this.longitude, });
}

class SearchLocationEvent extends WeatherEvent {
  final String location;

  SearchLocationEvent({required this.location});
}

