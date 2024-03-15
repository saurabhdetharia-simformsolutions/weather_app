import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../error/server_failures_exception.dart';
import '../domain/repositories/app_flavor_repository.dart';

class ApiServiceDio {
  final Dio dioService;
  final AppFlavorRepository appFlavorRepository;

  ApiServiceDio({required this.dioService, required this.appFlavorRepository});

  int timeOutSeconds = 30000;

  Future<Either<dynamic, dynamic>> get(
      {required String url,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameter,
        Map<String, dynamic>? headers,
        String isSearchLocationApi = ""}) async {
    try {
      queryParameter?['appid'] = '801e74f1b2c15fd3887d4623a7195755';
      String baseUrl = "";
      if (isSearchLocationApi.isNotEmpty) {
        baseUrl = isSearchLocationApi;
      } else {
        baseUrl = appFlavorRepository.getBaseUrl();
      }
      final uri = Uri.https(baseUrl, url, queryParameter);
      if (headers != null && headers.isNotEmpty) {
        dioService.options.headers.addAll(headers);
      }
      final response = await dioService
          .get(
        uri.toString(),
        cancelToken: cancelToken,
        options: Options(
          responseType: ResponseType.json,
        ),
      )
          .timeout(Duration(seconds: timeOutSeconds));

      final resJson = _response(response);

      return Right(resJson);
    } on DioError catch (e) {
      return processDioError(e);
    }
  }

  Left<dynamic, dynamic> processDioError(DioError e) {
    if (!CancelToken.isCancel(e)) {
      if (e.response != null) {
        return _response(e.response!);
      }
    }
    if (kDebugMode) {
      print(
          '============== +++++ Request canceled! ================= +++++++++${e.message}');
    }
    return Left(
        CancelApiException(error: Error(code: -5, message: "", name: "")));
  }

  dynamic _response(Response response) {
    var responseJson = response.data;
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
        final error = responseJson['Error'];
        bool containsCode = (error as Map).containsKey("Code");
        bool containsName = error.containsKey("Name");
        bool containsMessage = error.containsKey("Message");
        return Left(ServerFailuresException(
            error: Error(
                code: containsCode ? int.parse(error['Code']) : -1,
                message: containsMessage ? error['Message'] : "",
                name: containsName ? error["Name"] : "")));
      default:
    }
  }
}
