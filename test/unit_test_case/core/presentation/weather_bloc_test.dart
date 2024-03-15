import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart';
import 'package:weather_app/core/data/models/search_location/search_location_res.dart';
import 'package:weather_app/core/domain/use_cases/get_weather_details_useCase.dart';
import 'package:weather_app/core/domain/use_cases/search_location_usecase.dart';
import 'package:weather_app/core/presentation/weather/weather_bloc/weather_bloc.dart';
import 'package:weather_app/error/server_failures_exception.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([
  GetWeatherDetailsUseCase,
  SearchLocationUseCase,
  CancelToken,
])
void main() {
  late MockGetWeatherDetailsUseCase mockGetWeatherDetailsUseCase;
  late MockSearchLocationUseCase mockSearchLocationUseCase;
  late MockCancelToken mockCancelToken;
  late WeatherBloc weatherBloc;
  String searchTermForEmptyResponse = "WWEWXCCC222 ZX SD ";
  String searchTerm = "ABU";

  setUp(() {
    mockGetWeatherDetailsUseCase = MockGetWeatherDetailsUseCase();
    mockSearchLocationUseCase = MockSearchLocationUseCase();
    mockSearchLocationUseCase = MockSearchLocationUseCase();
    mockCancelToken = MockCancelToken();

    weatherBloc = WeatherBloc(
        getWeatherDetailsUseCase: mockGetWeatherDetailsUseCase,
        searchLocationUseCase: mockSearchLocationUseCase,
        cancelToken: mockCancelToken);
  });

  group('Current Weather', () {
    ServerFailuresException errorResponse = ServerFailuresException(
      error: Error(
        code: 500,
        message: 'Internal Server Error',
      ),
    );

    CurrentWeatherRes currentWeatherRes = CurrentWeatherRes(
        weather: [Weather(main: 'Clear')],
        main: Main(humidity: 39, feelsLike: 286.29),
        wind: Wind(speed: 10.29),
        clouds: Clouds(all: 0),
        name: 'Mountain View');
    blocTest<WeatherBloc, WeatherState>(
      'emits [LoadingDataState, CurrentWeatherState] '
      'when CurrentWeatherState is added and CurrentWeatherState call '
      'succeeds.',
      build: () {
        when(weatherBloc.getWeatherDetailsUseCase.call(any, any))
            .thenAnswer((_) async => Right(currentWeatherRes));
        return weatherBloc;
      },
      act: (bloc) {
        bloc.add(GetWeatherDetailsEvent(latitude: '14.02', longitude: '20.98'));
      },
      expect: () => [WeatherSuccess(weatherDetailsResponse: currentWeatherRes)],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [LoadingDataState, CurrentWeatherState] '
      'when CurrentWeatherState is added and CurrentWeatherState call '
      'fails.',
      build: () {
        when(weatherBloc.getWeatherDetailsUseCase.call(any, any))
            .thenAnswer((_) async => Left(errorResponse));
        return weatherBloc;
      },
      act: (bloc) {
        bloc.add(GetWeatherDetailsEvent(latitude: '14.02', longitude: '20.98'));
      },
      expect: () => [
        //TopAlbumsState.loadingState(),
        CurrentWeatherErrorState(message: 'Something went wrong')
      ],
    );
  });

  /**
   * Search Location
   */

  group('Search Location', () {
    ServerFailuresException errorResponse = ServerFailuresException(
      error: Error(
        code: 500,
        message: 'Internal Server Error',
      ),
    );

    SearchLocationRes searchLocationEmptyRes = SearchLocationRes(results: []);
    blocTest<WeatherBloc, WeatherState>(
      'emits [LoadingDataState, SearchLocationState] '
      'when SearchLocationEvent is added and SearchLocationUseCase call '
      'succeeds but returns an empty list.',
      build: () {
        when(weatherBloc.searchLocationUseCase.call(any, any))
            .thenAnswer((_) async => Right(searchLocationEmptyRes));
        return weatherBloc;
      },
      act: (bloc) {
        bloc.add(SearchLocationEvent(location: searchTermForEmptyResponse));
      },
      expect: () =>
          [SearchLocationState(searchLocationRes: searchLocationEmptyRes)],
    );

    List<Result> results = [
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

    SearchLocationRes searchLocationRes = SearchLocationRes(results: results);
    blocTest<WeatherBloc, WeatherState>(
      'emits [LoadingDataState, SearchLocationState] '
      'when SearchLocationEvent is added and SearchLocationUseCase call '
      'succeeds.',
      build: () {
        when(weatherBloc.searchLocationUseCase.call(any, any))
            .thenAnswer((_) async => Right(searchLocationRes));
        return weatherBloc;
      },
      act: (bloc) {
        bloc.add(SearchLocationEvent(location: searchTerm));
      },
      expect: () => [
        //TopAlbumsState.loadingState(),
        SearchLocationState(searchLocationRes: searchLocationRes)
      ],
    );
  });
}
