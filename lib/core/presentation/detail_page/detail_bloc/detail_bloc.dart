import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/domain/use_cases/get_daily_forecast_useCase.dart';
import '../../../data/models/daily_forecast/daily_forecast_res.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDailyForecastUseCase dailyForecastUseCase;

  DetailBloc({
    required this.dailyForecastUseCase,
  }) : super(DetailInitial()) {
    on<GetDetailForecastEvent>(_onGetWeatherDetails);
  }

  Future<FutureOr<void>> _onGetWeatherDetails(
      GetDetailForecastEvent event, Emitter<DetailState> emit) async {
    GetDailyForecastUseCaseParams params =
        GetDailyForecastUseCaseParams(queryParameter: {
      'lat': event.location.latitude.toString(),
      'lon': event.location.longitude.toString(),
      'cnt': '7'
    });

    final response = await dailyForecastUseCase.call(params, null);
    if (response.isLeft()) {
      /**
       * Failure Response
       */
    } else {
      /**
       * Success Response
       */
      var dailyForecastResponse = (response as Right).value as DailyForecast;

      emit(DetailSuccess(dailyForecastResponse: dailyForecastResponse));
    }
  }
}
