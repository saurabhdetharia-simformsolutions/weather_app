import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../error/server_failures_exception.dart';
import '../../domain/repositories/app_flavor_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../api_routes.dart' as ApiEndPoints;
import '../api_service.dart';
import '../models/search_location/search_location_res.dart';

class LocationRepositoryImp extends LocationRepository {
  final ApiServiceDio apiService;
  final AppFlavorRepository appFlavorRepository;

  LocationRepositoryImp(
      {required this.apiService, required this.appFlavorRepository});

  @override
  Future<Either<ServerFailuresException, SearchLocationRes>> searchLocation(
      {CancelToken? cancelToken,required Map<String, dynamic> queryParameter}) async {
    final response = await apiService.get(
        isSearchLocationApi: appFlavorRepository.getSearchLocationBaseUrl(),
        url: ApiEndPoints.searchLocation,
        cancelToken: cancelToken,
        queryParameter: queryParameter);

    try {
      final foldResponse = response.fold(
              (l) => ServerFailuresException(error: l.error),
              (r) => SearchLocationRes.fromCustomJson(r));
      if (response.isRight()) {
        final res = foldResponse as SearchLocationRes;
        return Right(res);
      } else {
        return Left(foldResponse as ServerFailuresException);
      }
    } catch (e) {
      return Left(ServerFailuresException.parsingException(e.toString()));
    }
  }
}
