import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart';
import '/core/domain/repositories/weather_repository.dart';
import '/error/server_failures_exception.dart';
import '../api_routes.dart' as ApiEndPoints;
import '../api_service.dart';

class WeatherRepositoryImp extends WeatherRepository {
  final ApiServiceDio apiService;

  WeatherRepositoryImp({required this.apiService});

  @override
  Future<Either<ServerFailuresException, CurrentWeatherRes>> getWeatherDetails(
      CancelToken? cancelToken, Map<String, dynamic> queryParameter) async {
    final response = await apiService.get(
        url: ApiEndPoints.getCurrentWeatherDetailsUrl,
        cancelToken: cancelToken,
        queryParameter: queryParameter);

    try {
      final foldResponse = response.fold(
          (l) => ServerFailuresException(error: l.error),
          (r) => CurrentWeatherRes.fromJson(r));
      if (response.isRight()) {
        final res = foldResponse as CurrentWeatherRes;
        return Right(res);
      } else {
        return Left(foldResponse as ServerFailuresException);
      }
    } catch (e) {
      return Left(ServerFailuresException.parsingException(e.toString()));
    }
  }
}
