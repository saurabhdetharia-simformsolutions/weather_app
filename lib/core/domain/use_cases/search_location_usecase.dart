import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../error/server_failures_exception.dart';
import '../../data/models/search_location/search_location_res.dart';
import '../repositories/location_repository.dart';
import 'base_usecase.dart';

class SearchLocationUseCase
    implements BaseUseCase<SearchLocationRes, SearchLocationUseCaseParams> {
  final LocationRepository locationRepository;

  SearchLocationUseCase(
      {required this.locationRepository});

  @override
  Future<Either<ServerFailuresException, SearchLocationRes>> call(
      SearchLocationUseCaseParams? params,
      [CancelToken? cancelToken]) async {
    var response = await locationRepository.searchLocation(
        cancelToken: cancelToken, queryParameter: params!.queryParameter);
    if (response is Right) {
      final model = (response as Right).value as SearchLocationRes;

      return Right(model);
    }

    return Left(getSimplifyLeftValue(response));
  }
}

class SearchLocationUseCaseParams {
  final Map<String, dynamic> queryParameter;

  SearchLocationUseCaseParams({required this.queryParameter});
}
