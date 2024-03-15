import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../error/server_failures_exception.dart';
import '../../data/models/current_weather/current_weather_res.dart';
import '../repositories/app_setting_repository.dart';
import '../repositories/weather_repository.dart';
import 'base_usecase.dart';

class GetWeatherDetailsUseCase
    implements BaseUseCase<CurrentWeatherRes, GetWeatherDetailsUseCaseParams> {
  final WeatherRepository weatherRepository;

  GetWeatherDetailsUseCase({required this.weatherRepository});

  @override
  Future<Either<ServerFailuresException, CurrentWeatherRes>> call(
      GetWeatherDetailsUseCaseParams? params,
      [CancelToken? cancelToken]) async {
    var response = await weatherRepository.getWeatherDetails(
        cancelToken, params!.queryParameter);
    if (response is Right) {
      final model = (response as Right).value as CurrentWeatherRes;

      return Right(model);
    }

    return Left(getSimplifyLeftValue(response));
  }
}

class GetWeatherDetailsUseCaseParams {
  final Map<String, dynamic> queryParameter;

  GetWeatherDetailsUseCaseParams({required this.queryParameter});
}
