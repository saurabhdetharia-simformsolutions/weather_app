import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../error/server_failures_exception.dart';

abstract class BaseUseCase<Type, Param> {
  Future<Either<ServerFailuresException, Type>> call(
      Param? params, [CancelToken? cancelToken]);
}

getSimplifyLeftValue(Either<ServerFailuresException, dynamic> response){
  return (response as Left).value;
}

class NoParams {}
