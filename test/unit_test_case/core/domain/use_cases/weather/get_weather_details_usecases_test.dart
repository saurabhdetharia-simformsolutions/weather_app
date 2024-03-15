import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart';
import 'package:weather_app/core/domain/repositories/weather_repository.dart';
import 'package:weather_app/core/domain/use_cases/get_weather_details_useCase.dart';
import 'package:weather_app/error/server_failures_exception.dart';

import 'get_weather_details_usecases_test.mocks.dart';

@GenerateMocks([
  WeatherRepository,
  CancelToken,
])
void main() {
  late final MockWeatherRepository mockWeatherRepository;
  late final GetWeatherDetailsUseCase mockGetWeatherDetailsUseCase;
  late final GetWeatherDetailsTestMock testMock;
  late final GetWeatherTestParameters testParameters;

  setUpAll(() {
    mockWeatherRepository = MockWeatherRepository();
    mockGetWeatherDetailsUseCase =
        GetWeatherDetailsUseCase(weatherRepository: mockWeatherRepository);
    final mockCancelToken = MockCancelToken();
    testParameters = GetWeatherTestParameters(cancelToken: mockCancelToken);
    testMock = GetWeatherDetailsTestMock(
      repository: mockWeatherRepository,
      params: testParameters,
    );
  });

  group('Current Weather', () {
    // Success Response
    test(
      'Should succeed fetching Current Weather from server response.',
      () async {
        // arrange
        testMock.withSuccess();

        // act
        final result = await mockGetWeatherDetailsUseCase.call(
          GetWeatherDetailsUseCaseParams(
              queryParameter: testParameters.queryParams),
          testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Right<ServerFailuresException, CurrentWeatherRes>>(),
        );

        verify(
          mockWeatherRepository.getWeatherDetails(
            testParameters.cancelToken,
            testParameters.queryParams,
          ),
        );

        verifyNoMoreInteractions(mockWeatherRepository);
      },
    );

    // Failure Response
    test(
      'Should fail to fetch Current Weather from server response.',
      () async {
        // arrange
        testMock.withError();

        // act
        final result = await mockGetWeatherDetailsUseCase.call(
          GetWeatherDetailsUseCaseParams(
              queryParameter: testParameters.queryParams),
          testParameters.cancelToken,
        );

        // assert
        expect(
          result,
          isA<Left<ServerFailuresException, CurrentWeatherRes>>(),
        );

        verify(
          mockWeatherRepository.getWeatherDetails(
            testParameters.cancelToken,
            testParameters.queryParams,
          ),
        );

        verifyNoMoreInteractions(mockWeatherRepository);
      },
    );
  });
}

class GetWeatherDetailsTestMock {
  const GetWeatherDetailsTestMock({
    required this.repository,
    required this.params,
  });

  final WeatherRepository repository;
  final GetWeatherTestParameters params;

  void withSuccess() {
    _mock().thenAnswer(
      (_) async => Right(GetWeatherTestResponses.success),
    );
  }

  void withError() {
    _mock().thenAnswer(
      (_) async => Left(GetWeatherTestResponses.error),
    );
  }

  PostExpectation<Future<Either<ServerFailuresException, CurrentWeatherRes>>>
      _mock<T>() {
    return when(
      repository.getWeatherDetails(
        params.cancelToken,
        params.queryParams,
      ),
    );
  }
}

class GetWeatherTestParameters {
  const GetWeatherTestParameters({
    required this.cancelToken,
    this.queryParams = const <String, dynamic>{},
  });

  final CancelToken cancelToken;
  final Map<String, dynamic> queryParams;
}

class GetWeatherTestResponses {
  GetWeatherTestResponses._();

  static ServerFailuresException error = ServerFailuresException(
    error: Error(
      code: 500,
      message: 'Internal Server Error',
    ),
  );

  static CurrentWeatherRes success = CurrentWeatherRes(
      weather: [Weather(main: 'Clear')],
      main: Main(humidity: 39, feelsLike: 286.29),
      wind: Wind(speed: 10.29),
      clouds: Clouds(all: 0),
      name: 'Mountain View');
}
