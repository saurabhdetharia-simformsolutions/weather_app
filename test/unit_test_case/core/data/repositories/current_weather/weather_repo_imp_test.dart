import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/data/api_routes.dart' as api_end_points;
import 'package:weather_app/core/data/api_service.dart';
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart';
import 'package:weather_app/core/data/repositories/weather_repository_imp.dart';
import 'package:weather_app/core/domain/repositories/weather_repository.dart';
import 'package:weather_app/error/server_failures_exception.dart';

import 'weather_repo_imp_test.mocks.dart';

@GenerateMocks([ApiServiceDio, CancelToken])
void main() {
  late final WeatherRepository weatherRepository;
  late final WeatherTestParameters testParameters;
  late final WeatherApiMock apiMock;

  setUpAll(() {
    final mockCancelToken = MockCancelToken();
    final mockApiServiceDio = MockApiServiceDio();

    weatherRepository = WeatherRepositoryImp(apiService: mockApiServiceDio);
    testParameters = WeatherTestParameters(cancelToken: mockCancelToken);
    apiMock = WeatherApiMock(
      apiServiceDio: mockApiServiceDio,
      params: testParameters,
    );
  });

  group('Current Weather', () {
    // Success response
    test(
      'Should succeed fetching Current Weather data from server response.',
      () async {
        // arrange
        apiMock.withSuccess();
        // act
        final result = await weatherRepository.getWeatherDetails(
          testParameters.cancelToken,
          testParameters.queryParams,
        );

        // assert
        expect(
          result,
          isA<Right<ServerFailuresException, CurrentWeatherRes>>(),
        );
      },
    );

    // Failure response
    test(
      'Should fail fetching Current Weather from server response',
      () async {
        // arrange
        apiMock.withError();

        // act
        final result = await weatherRepository.getWeatherDetails(
          testParameters.cancelToken,
          testParameters.queryParams,
        );

        // assert
        expect(
          result,
          isA<Left<ServerFailuresException, CurrentWeatherRes>>(),
        );
      },
    );
  });
}

class WeatherApiMock {
  const WeatherApiMock({
    required this.apiServiceDio,
    required this.params,
  });

  final MockApiServiceDio apiServiceDio;
  final WeatherTestParameters params;

  void withEmpty() => _mock()
      .thenAnswer((_) async => const Right(WeatherTestResponses.emptySuccess));

  void withSuccess() {
    _mock().thenAnswer(
      (_) async => const Right(WeatherTestResponses.success),
    );
  }

  void withError() {
    _mock().thenAnswer(
      (_) async => Left(WeatherTestResponses.error),
    );
  }

  PostExpectation<Future<Either>> _mock<T>() {
    return when(
      apiServiceDio.get(
        url: params.url,
        cancelToken: params.cancelToken,
        queryParameter: params.queryParams,
      ),
    );
  }
}

class WeatherTestParameters {
  const WeatherTestParameters({
    required this.cancelToken,
    this.url = api_end_points.getCurrentWeatherDetailsUrl,
    this.queryParams = const <String, dynamic>{},
  });

  final CancelToken cancelToken;
  final String url;
  final Map<String, dynamic> queryParams;
}

class WeatherTestResponses {
  const WeatherTestResponses._();

  static ServerFailuresException error = ServerFailuresException(
    error: Error(
      code: 500,
      message: 'Internal Server Error',
    ),
  );

  static const success = {
    "coord": {"lon": -122.084, "lat": 37.422},
    "weather": [
      {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
    ],
    "base": "stations",
    "main": {
      "temp": 287.76,
      "feels_like": 286.29,
      "temp_min": 285.75,
      "temp_max": 289.44,
      "pressure": 1016,
      "humidity": 39
    },
    "visibility": 10000,
    "wind": {"speed": 10.29, "deg": 360, "gust": 14.4},
    "clouds": {"all": 0},
    "dt": 1710435445,
    "sys": {
      "type": 2,
      "id": 2010364,
      "country": "US",
      "sunrise": 1710426002,
      "sunset": 1710468887
    },
    "timezone": -25200,
    "id": 5375480,
    "name": "Mountain View",
    "cod": 200
  };

  static const emptySuccess = {"generationtime_ms": 2.0920038};
}
