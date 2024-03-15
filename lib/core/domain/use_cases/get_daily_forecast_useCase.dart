import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/data/models/daily_forecast/daily_forecast_res.dart';
import 'package:weather_app/core/domain/repositories/forecast_repository.dart';
import '../../../error/server_failures_exception.dart';
import '../../data/models/current_weather/current_weather_res.dart';
import '../repositories/app_setting_repository.dart';
import '../repositories/weather_repository.dart';
import 'base_usecase.dart';

class GetDailyForecastUseCase
    implements BaseUseCase<DailyForecast, GetDailyForecastUseCaseParams> {
  final ForecastRepository forecastRepository;
  final AppSettingRepository appSettingRepository;

  GetDailyForecastUseCase(
      {required this.forecastRepository, required this.appSettingRepository});

  @override
  Future<Either<ServerFailuresException, DailyForecast>> call(
      GetDailyForecastUseCaseParams? params,
      [CancelToken? cancelToken]) async {
    var response = await forecastRepository.getDailyForecast(
        cancelToken, params!.queryParameter);
    if (response is Right) {
      final model = (response as Right).value as DailyForecast;

      return Right(model);
    }

    return Left(getSimplifyLeftValue(response));
  }
}

class GetDailyForecastUseCaseParams {
  final Map<String, dynamic> queryParameter;

  GetDailyForecastUseCaseParams({required this.queryParameter});
}
