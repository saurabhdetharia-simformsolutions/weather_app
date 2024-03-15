part of 'detail_bloc.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailSuccess extends DetailState {

  DailyForecast dailyForecastResponse;

  DetailSuccess({
    required this.dailyForecastResponse,
  });
}
