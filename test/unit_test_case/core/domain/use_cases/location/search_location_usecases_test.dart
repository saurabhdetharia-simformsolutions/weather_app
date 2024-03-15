import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/data/models/search_location/search_location_res.dart';
import 'package:weather_app/core/domain/repositories/location_repository.dart';
import 'package:weather_app/core/domain/use_cases/search_location_usecase.dart';
import 'package:weather_app/error/server_failures_exception.dart';

import 'search_location_usecases_test.mocks.dart';

@GenerateMocks([
  LocationRepository,
  CancelToken,
])
void main() {
  late final MockLocationRepository mockLocationRepository;
  late final SearchLocationUseCase mockSearchLocationUseCase;
  late final SearchLocationTestMock testMock;
  late final SearchLocationTestParameters testParameters;

  setUpAll(() {
    mockLocationRepository = MockLocationRepository();
    mockSearchLocationUseCase =
        SearchLocationUseCase(locationRepository: mockLocationRepository);
    final mockCancelToken = MockCancelToken();
    testParameters = SearchLocationTestParameters(cancelToken: mockCancelToken);
    testMock = SearchLocationTestMock(
      repository: mockLocationRepository,
      params: testParameters,
    );
  });

  group('Searched location', () {
    // Success Response
    test(
      'Should succeed fetching searched location from server response.',
      () async {
        // arrange
        testMock.withSuccess();

        // act
        final result = await mockSearchLocationUseCase.call(
          SearchLocationUseCaseParams(
              queryParameter: testParameters.queryParams),
          testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Right<ServerFailuresException, SearchLocationRes>>(),
        );

        verify(
          mockLocationRepository.searchLocation(
            queryParameter: testParameters.queryParams,
            cancelToken: testParameters.cancelToken,
          ),
        );

        verifyNoMoreInteractions(mockLocationRepository);
      },
    );

    // Failure Response
    test(
      'Should fail to fetch searched location from server response.',
      () async {
        // arrange
        testMock.withError();

        // act
        final result = await mockSearchLocationUseCase.call(
          SearchLocationUseCaseParams(
              queryParameter: testParameters.queryParams),
          testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Left<ServerFailuresException, SearchLocationRes>>(),
        );

        verify(
          mockLocationRepository.searchLocation(
            queryParameter: testParameters.queryParams,
            cancelToken: testParameters.cancelToken,
          ),
        );

        verifyNoMoreInteractions(mockLocationRepository);
      },
    );
  });
}

class SearchLocationTestMock {
  const SearchLocationTestMock({
    required this.repository,
    required this.params,
  });

  final LocationRepository repository;
  final SearchLocationTestParameters params;

  void withSuccess() {
    _mock().thenAnswer(
      (_) async => Right(
          SearchLocationRes(results: SearchLocationTestResponses.success)),
    );
  }

  void withError() {
    _mock().thenAnswer(
      (_) async => Left(SearchLocationTestResponses.error),
    );
  }

  PostExpectation<Future<Either<ServerFailuresException, SearchLocationRes>>>
      _mock<T>() {
    return when(
      repository.searchLocation(
        cancelToken: params.cancelToken,
        queryParameter: params.queryParams,
      ),
    );
  }
}

class SearchLocationTestParameters {
  const SearchLocationTestParameters({
    required this.cancelToken,
    this.queryParams = const <String, dynamic>{},
  });

  final CancelToken cancelToken;
  final Map<String, dynamic> queryParams;
}

class SearchLocationTestResponses {
  SearchLocationTestResponses._();

  static ServerFailuresException error = ServerFailuresException(
    error: Error(
      code: 500,
      message: 'Internal Server Error',
    ),
  );

  static List<Result> success = [
    Result(
        id: 2352778,
        name: "Abuja",
        latitude: 9.05785,
        longitude: 7.49508,
        countryCode: 'NG',
        country: 'Nigeria'),
    Result(
        id: 1651103,
        name: "Atambua",
        latitude: -9.10611,
        longitude: 124.8925,
        countryCode: 'ID',
        country: 'Indonesia')
  ];
}
