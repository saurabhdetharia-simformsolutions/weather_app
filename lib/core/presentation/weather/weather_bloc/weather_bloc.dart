import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/core/domain/repositories/app_setting_repository.dart';

import '../../../../core/domain/use_cases/get_weather_details_useCase.dart';
import '../../../data/models/current_weather/current_weather_res.dart';
import '../../../data/models/search_location/search_location_res.dart';
import '../../../domain/use_cases/search_location_usecase.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDetailsUseCase getWeatherDetailsUseCase;
  final SearchLocationUseCase searchLocationUseCase;
  final AppSettingRepository appSettingRepository;
  final CancelToken cancelToken;

  WeatherBloc(
      {required this.getWeatherDetailsUseCase,
      required this.searchLocationUseCase,
      required this.appSettingRepository,
      required this.cancelToken})
      : super(WeatherInitial()) {
    on<GetWeatherDetailsEvent>(_onGetWeatherDetails);
    on<SearchLocationEvent>(_onSearchLocation);
  }

  Future<FutureOr<void>> _onGetWeatherDetails(
      GetWeatherDetailsEvent event, Emitter<WeatherState> emit) async {

    // This will set if the temperature in celsius or fahrenheit
    isCelsius = appSettingRepository.shouldShowCelsius();



    GetWeatherDetailsUseCaseParams params =
        GetWeatherDetailsUseCaseParams(queryParameter: {
      'lat': event.latitude.toString(),
      'lon': event.longitude.toString(),
    });

    final response = await getWeatherDetailsUseCase.call(params, null);
    if (response.isLeft()) {
      /**
       * Failure Response
       */
      emit(CurrentWeatherErrorState(
          message: 'Please try again. Something went wrong'));
    } else {
      /**
       * Success Response
       */
      var weatherDetails = (response as Right).value as CurrentWeatherRes;

      appSettingRepository.saveWeatherInfo(jsonEncode(weatherDetails));

      emit(WeatherSuccess(weatherDetailsResponse: weatherDetails));
    }
  }

  Future<FutureOr<void>> _onSearchLocation(
      SearchLocationEvent event, Emitter<WeatherState> emit) async {
    SearchLocationUseCaseParams params = SearchLocationUseCaseParams(
        queryParameter: {
          'name': event.location,
          'count': '5',
          'language': 'en',
          'format': 'json'
        });

    final response = await searchLocationUseCase.call(params, null);
    if (response.isLeft()) {
      /**
       * Failure Response
       */
      emit(SearchLocationErrorState(
          message: 'Please try again. Something went wrong.'));
    } else {
      /**
       * Success Response
       */
      var searchLocationRes = (response as Right).value as SearchLocationRes;

      emit(SearchLocationState(searchLocationRes: searchLocationRes));
    }
  }
}
