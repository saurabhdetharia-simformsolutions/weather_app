import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../error/server_failures_exception.dart';
import '../../data/models/current_weather/current_weather_res.dart';

abstract class WeatherRepository {
  Future<Either<ServerFailuresException, CurrentWeatherRes>> getWeatherDetails(
      CancelToken? cancelToken,Map<String,dynamic> queryParameter);
}
