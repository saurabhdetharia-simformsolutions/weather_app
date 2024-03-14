import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/domain/use_cases/get_weather_details_useCase.dart';
import '../../../data/models/current_weather/current_weather_res.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDetailsUseCase getWeatherDetailsUseCase;

  WeatherBloc({
    required this.getWeatherDetailsUseCase,
  }) : super(WeatherInitial()) {
    on<GetWeatherDetailsEvent>(_onGetWeatherDetails);
  }

  Future<FutureOr<void>> _onGetWeatherDetails(
      GetWeatherDetailsEvent event, Emitter<WeatherState> emit) async {
    GetWeatherDetailsUseCaseParams params =
        GetWeatherDetailsUseCaseParams(queryParameter: {
      'lat': event.location.latitude.toString(),
      'lon': event.location.longitude.toString(),
    });

    final response = await getWeatherDetailsUseCase.call(params, null);
    if (response.isLeft()) {
      /**
       * Failure Response
       */
    } else {
      /**
       * Success Response
       */
      var weatherDetails = (response as Right).value as CurrentWeatherRes;

      // emit(UserDetailsState.getUserDetail(userDetail: userDetail));
    }
  }
}
