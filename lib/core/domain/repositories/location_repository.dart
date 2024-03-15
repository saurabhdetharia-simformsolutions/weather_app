import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../error/server_failures_exception.dart';
import '../../data/models/search_location/search_location_res.dart';

abstract class LocationRepository {
  Future<Either<ServerFailuresException, SearchLocationRes>> searchLocation(
      {CancelToken? cancelToken, required Map<String, dynamic> queryParameter});
}
