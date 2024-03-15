import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/const.dart';
import 'package:weather_app/core/domain/repositories/app_setting_repository.dart';

import '../../../../core/domain/use_cases/get_weather_details_useCase.dart';
import '../../../../helper.dart';
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
    on<WeatherTempConvertEvent>(_onTempConvert);
  }

  /// If the user location is changed within one kilometer
  /// or the user has revisited app within frequency duration,
  /// show local data, other wise fetch latest data
  Future<FutureOr<void>> _onGetWeatherDetails(
      GetWeatherDetailsEvent event, Emitter<WeatherState> emit) async {
    /// This will set if the temperature in celsius or fahrenheit
    isCelsius = appSettingRepository.shouldShowCelsius();

    /// Calculate the last location
    var lastLat = appSettingRepository.getLat();
    var lastLong = appSettingRepository.getLong();

    var distanceInKms = calculateDistance(
      lat1: lastLat,
      lat2: double.tryParse(event.latitude ?? '0') ?? 0,
      lon1: lastLong,
      lon2: double.tryParse(event.longitude ?? '0') ?? 0,
    );

    if (event.latitude == null || event.longitude == null) {
      /// Send local stored data
      var weatherInfoStr = appSettingRepository.getWeatherInfo();
      if(weatherInfoStr.isEmpty){
        emit(WeatherSuccess(
            weatherDetailsResponse:
            CurrentWeatherRes.fromJson(jsonDecode(weatherInfoStr))));
      }
    } else {
      /// Get frequency duration
      var isTenMinsEnabled = appSettingRepository.isTenMinsEnabled();
      var isThirtyMinsEnabled = appSettingRepository.isThirtyMinsEnabled();
      var isSixtyMinsEnabled = appSettingRepository.isSixtyMinsEnabled();

      var freqInMins = isTenMinsEnabled
          ? 10
          : isThirtyMinsEnabled
              ? 30
              : isSixtyMinsEnabled
                  ? 60
                  : 10;

      /// Last access time
      var lastAccessTimeStr = appSettingRepository.getLastOpenTime();
      DateTime lastAccessTime;
      if (lastAccessTimeStr.isNotEmpty) {
        lastAccessTime = DateTime.parse(lastAccessTimeStr);
      } else {
        lastAccessTime = DateTime.now();
      }

      var durationDifference = DateTime.now().difference(lastAccessTime);

      // Check if distance is grater than 1 km or
      // duration is grater than frequency duration
      // fetch the latest data from the server
      if (distanceInKms > 1 || durationDifference.inMinutes > freqInMins) {
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

          appSettingRepository.saveLastOpenTime(DateTime.now().toString());
          appSettingRepository.setLat((event.latitude ?? 0).toString());
          appSettingRepository.setLong((event.longitude ?? 0).toString());
          appSettingRepository.saveWeatherInfo(jsonEncode(weatherDetails));

          if (event.name != null) {
            emit(WeatherSuccess(
                weatherDetailsResponse: weatherDetails.copyWith(
              name: event.name,
            )));
          } else {
            emit(WeatherSuccess(weatherDetailsResponse: weatherDetails));
          }
        }
      } else {
        /// Send local stored data
        var weatherInfoStr = appSettingRepository.getWeatherInfo();
        emit(WeatherSuccess(
            weatherDetailsResponse:
                CurrentWeatherRes.fromJson(jsonDecode(weatherInfoStr))));
      }
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

  FutureOr<void> _onTempConvert(
      WeatherTempConvertEvent event, Emitter<WeatherState> emit) {
    emit(WeatherSuccess(weatherDetailsResponse: event.weatherDetailsResponse));
  }
}
