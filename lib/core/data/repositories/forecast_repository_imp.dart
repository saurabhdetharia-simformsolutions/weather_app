import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/error/server_failures_exception.dart';
import '../../domain/repositories/forecast_repository.dart';
import '../api_routes.dart' as ApiEndPoints;
import '../api_service.dart';
import '../models/daily_forecast/daily_forecast_res.dart';

class ForecastRepositoryImp extends ForecastRepository {
  final ApiServiceDio apiService;

  ForecastRepositoryImp({required this.apiService});

  @override
  Future<Either<ServerFailuresException, DailyForecast>> getDailyForecast(
      CancelToken? cancelToken, Map<String, dynamic> queryParameter) async {
    final response = await apiService.get(
        url: ApiEndPoints.getDailyForecastsUrl,
        cancelToken: cancelToken,
        queryParameter: queryParameter);

    try {
      final foldResponse = response.fold(
          (l) => ServerFailuresException(error: l.error),
          (r) => DailyForecast.fromJson(r));
      if (response.isRight()) {
        final res = foldResponse as DailyForecast;
        return Right(res);
      } else {
        return Left(foldResponse as ServerFailuresException);
      }
    } catch (e) {
      return Left(ServerFailuresException.parsingException(e.toString()));
    }
  }
}
