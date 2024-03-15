part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherSuccess extends WeatherState {

  CurrentWeatherRes weatherDetailsResponse;

  WeatherSuccess({
    required this.weatherDetailsResponse,
  });
}

class CurrentWeatherErrorState extends WeatherState {

  final String message;

  CurrentWeatherErrorState({required this.message});
}


class SearchLocationState extends WeatherState {
  final SearchLocationRes searchLocationRes;

  SearchLocationState({required this.searchLocationRes});

  @override
  List<Object?> get props => [searchLocationRes];
}

class SearchLocationErrorState extends WeatherState {
  final String message;

  SearchLocationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
