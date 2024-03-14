part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeatherDetailsEvent extends WeatherEvent {
  final Position location;

  GetWeatherDetailsEvent({required this.location});
}
