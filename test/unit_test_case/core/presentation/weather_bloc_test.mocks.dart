// Mocks generated by Mockito 5.4.4 from annotations
// in weather_app/test/unit_test_case/core/presentation/weather_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i3;
import 'package:dio/dio.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart'
    as _i9;
import 'package:weather_app/core/data/models/search_location/search_location_res.dart'
    as _i11;
import 'package:weather_app/core/domain/repositories/location_repository.dart'
    as _i4;
import 'package:weather_app/core/domain/repositories/weather_repository.dart'
    as _i2;
import 'package:weather_app/core/domain/use_cases/get_weather_details_useCase.dart'
    as _i6;
import 'package:weather_app/core/domain/use_cases/search_location_usecase.dart'
    as _i10;
import 'package:weather_app/error/server_failures_exception.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherRepository_0 extends _i1.SmartFake
    implements _i2.WeatherRepository {
  _FakeWeatherRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocationRepository_2 extends _i1.SmartFake
    implements _i4.LocationRepository {
  _FakeLocationRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDioException_3 extends _i1.SmartFake implements _i5.DioException {
  _FakeDioException_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWeatherDetailsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWeatherDetailsUseCase extends _i1.Mock
    implements _i6.GetWeatherDetailsUseCase {
  MockGetWeatherDetailsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WeatherRepository get weatherRepository => (super.noSuchMethod(
        Invocation.getter(#weatherRepository),
        returnValue: _FakeWeatherRepository_0(
          this,
          Invocation.getter(#weatherRepository),
        ),
      ) as _i2.WeatherRepository);

  @override
  _i7.Future<
      _i3.Either<_i8.ServerFailuresException, _i9.CurrentWeatherRes>> call(
    _i6.GetWeatherDetailsUseCaseParams? params, [
    _i5.CancelToken? cancelToken,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            params,
            cancelToken,
          ],
        ),
        returnValue: _i7.Future<
                _i3.Either<_i8.ServerFailuresException,
                    _i9.CurrentWeatherRes>>.value(
            _FakeEither_1<_i8.ServerFailuresException, _i9.CurrentWeatherRes>(
          this,
          Invocation.method(
            #call,
            [
              params,
              cancelToken,
            ],
          ),
        )),
      ) as _i7.Future<
          _i3.Either<_i8.ServerFailuresException, _i9.CurrentWeatherRes>>);
}

/// A class which mocks [SearchLocationUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchLocationUseCase extends _i1.Mock
    implements _i10.SearchLocationUseCase {
  MockSearchLocationUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.LocationRepository get locationRepository => (super.noSuchMethod(
        Invocation.getter(#locationRepository),
        returnValue: _FakeLocationRepository_2(
          this,
          Invocation.getter(#locationRepository),
        ),
      ) as _i4.LocationRepository);

  @override
  _i7.Future<
      _i3.Either<_i8.ServerFailuresException, _i11.SearchLocationRes>> call(
    _i10.SearchLocationUseCaseParams? params, [
    _i5.CancelToken? cancelToken,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            params,
            cancelToken,
          ],
        ),
        returnValue: _i7.Future<
                _i3.Either<_i8.ServerFailuresException,
                    _i11.SearchLocationRes>>.value(
            _FakeEither_1<_i8.ServerFailuresException, _i11.SearchLocationRes>(
          this,
          Invocation.method(
            #call,
            [
              params,
              cancelToken,
            ],
          ),
        )),
      ) as _i7.Future<
          _i3.Either<_i8.ServerFailuresException, _i11.SearchLocationRes>>);
}

/// A class which mocks [CancelToken].
///
/// See the documentation for Mockito's code generation for more information.
class MockCancelToken extends _i1.Mock implements _i5.CancelToken {
  MockCancelToken() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set requestOptions(_i5.RequestOptions? _requestOptions) => super.noSuchMethod(
        Invocation.setter(
          #requestOptions,
          _requestOptions,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get isCancelled => (super.noSuchMethod(
        Invocation.getter(#isCancelled),
        returnValue: false,
      ) as bool);

  @override
  _i7.Future<_i5.DioException> get whenCancel => (super.noSuchMethod(
        Invocation.getter(#whenCancel),
        returnValue: _i7.Future<_i5.DioException>.value(_FakeDioException_3(
          this,
          Invocation.getter(#whenCancel),
        )),
      ) as _i7.Future<_i5.DioException>);

  @override
  void cancel([Object? reason]) => super.noSuchMethod(
        Invocation.method(
          #cancel,
          [reason],
        ),
        returnValueForMissingStub: null,
      );
}