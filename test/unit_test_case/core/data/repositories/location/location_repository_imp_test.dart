import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/data/api_routes.dart' as api_end_points;
import 'package:weather_app/core/data/api_service.dart';
import 'package:weather_app/core/data/models/search_location/search_location_res.dart';
import 'package:weather_app/core/data/repositories/app_flavor_repository_imp.dart';
import 'package:weather_app/core/data/repositories/location_repository.dart';
import 'package:weather_app/core/domain/repositories/app_flavor_repository.dart';
import 'package:weather_app/core/domain/repositories/location_repository.dart';
import 'package:weather_app/error/server_failures_exception.dart';
import 'location_repository_imp_test.mocks.dart';

@GenerateMocks([ApiServiceDio, CancelToken, AppFlavorRepository])
void main() {
  late final LocationRepository locationRepository;
  late final SearchLocationTestParameters testParameters;
  late final SearchLocationApiMock apiMock;
  late final AppFlavorRepository mockAppFlavorRepository;

  setUpAll(() {
    final mockCancelToken = MockCancelToken();
    final mockApiServiceDio = MockApiServiceDio();
    mockAppFlavorRepository = AppFlavorRepositoryImp();

    locationRepository = LocationRepositoryImp(
        apiService: mockApiServiceDio,
        appFlavorRepository: mockAppFlavorRepository);
    testParameters = SearchLocationTestParameters(cancelToken: mockCancelToken);
    apiMock = SearchLocationApiMock(
        apiServiceDio: mockApiServiceDio,
        params: testParameters,
        appFlavorRepository: mockAppFlavorRepository);
  });

  group('search location', () {
    // Success response
    test(
      'Should succeed fetching Searched location data from server response.',
      () async {
        // arrange
        apiMock.withSuccess();
        // act
        final result = await locationRepository.searchLocation(
          queryParameter: testParameters.queryParams,
          cancelToken: testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Right<ServerFailuresException, SearchLocationRes>>(),
        );
      },
    );

    // Failure response
    test(
      'Should fail fetching Searched Location from server response',
      () async {
        // arrange
        apiMock.withError();

        // act
        final result = await locationRepository.searchLocation(
          queryParameter: testParameters.queryParams,
          cancelToken: testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Left<ServerFailuresException, SearchLocationRes>>(),
        );
      },
    );

    // Parsing failure response
    test(
      'Should succeed fetching Searched location empty data from server response',
      () async {
        // arrange
        apiMock.withEmpty();

        // act
        final result = await locationRepository.searchLocation(
          queryParameter: testParameters.queryParams,
          cancelToken: testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Right<ServerFailuresException, SearchLocationRes>>(),
        );
      },
    );
  });
}

class SearchLocationApiMock {
  const SearchLocationApiMock(
      {required this.apiServiceDio,
      required this.params,
      required this.appFlavorRepository});

  final AppFlavorRepository appFlavorRepository;
  final ApiServiceDio apiServiceDio;
  final SearchLocationTestParameters params;

  void withEmpty() =>
      _mock().thenAnswer((_) async => const Right(SearchLocationTestResponses.emptySuccess));

  void withSuccess() {
    _mock().thenAnswer(
      (_) async => const Right(SearchLocationTestResponses.success),
    );
  }

  void withError() {
    _mock().thenAnswer(
      (_) async => Left(SearchLocationTestResponses.error),
    );
  }

  PostExpectation<Future<Either>> _mock<T>() {
    return when(
      apiServiceDio.get(
          url: params.url,
          cancelToken: params.cancelToken,
          queryParameter: params.queryParams,
          isSearchLocationApi: appFlavorRepository.getSearchLocationBaseUrl()),
    );
  }
}

class SearchLocationTestParameters {
  const SearchLocationTestParameters({
    required this.cancelToken,
    this.url = api_end_points.searchLocation,
    this.queryParams = const <String, dynamic>{},
  });

  final CancelToken cancelToken;
  final String url;
  final Map<String, dynamic> queryParams;
}

class SearchLocationTestResponses {
  const SearchLocationTestResponses._();

  static ServerFailuresException error = ServerFailuresException(
    error: Error(
      code: 500,
      message: 'Internal Server Error',
    ),
  );

  static const success = {
    "results": [
      {
        "id": 1651103,
        "name": "Atambua",
        "latitude": -9.10611,
        "longitude": 124.8925,
        "elevation": 336.0,
        "feature_code": "PPLA2",
        "country_code": "ID",
        "admin1_id": 1633791,
        "timezone": "Asia/Makassar",
        "population": 35793,
        "country_id": 1643084,
        "country": "Indonesia",
        "admin1": "East Nusa Tenggara"
      },
      {
        "id": 2352778,
        "name": "Abuja",
        "latitude": 9.05785,
        "longitude": 7.49508,
        "elevation": 476.0,
        "feature_code": "PPLC",
        "country_code": "NG",
        "admin1_id": 2352776,
        "admin2_id": 8635054,
        "timezone": "Africa/Lagos",
        "population": 590400,
        "country_id": 2328926,
        "country": "Nigeria",
        "admin1": "FCT",
        "admin2": "Municipal Area Council"
      }
    ],
    "generationtime_ms": 2.0920038
  };

  static const emptySuccess = {
    "generationtime_ms": 2.0920038
  };
}
