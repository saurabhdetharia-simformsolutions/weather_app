import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/domain/use_cases/get_daily_forecast_useCase.dart';

import '../../../data/models/daily_forecast/daily_forecast_res.dart';
import '../../../domain/repositories/app_setting_repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDailyForecastUseCase dailyForecastUseCase;
  final AppSettingRepository appSettingRepository;

  DetailBloc({
    required this.dailyForecastUseCase,
    required this.appSettingRepository,
  }) : super(DetailInitial()) {
    on<GetDetailForecastEvent>(_onGetWeatherDetails);
  }

  Future<FutureOr<void>> _onGetWeatherDetails(
      GetDetailForecastEvent event, Emitter<DetailState> emit) async {
    if (event.location == null) {
      // For offline support
      var dailyForecastResponse = appSettingRepository.getDailyForecastInfo();

      emit(DetailSuccess(
          dailyForecastResponse:
              DailyForecast.fromJson(jsonDecode(dailyForecastResponse))));
    } else {
      GetDailyForecastUseCaseParams params =
          GetDailyForecastUseCaseParams(queryParameter: {
        'lat': event.location?.latitude.toString(),
        'lon': event.location?.longitude.toString(),
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

        // For offline support
        appSettingRepository
            .saveDailyForecastInfo(jsonEncode(dailyForecastResponse));

        emit(DetailSuccess(dailyForecastResponse: dailyForecastResponse));
      }
    }
  }
}
