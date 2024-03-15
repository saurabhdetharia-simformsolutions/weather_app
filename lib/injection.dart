import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/domain/repositories/forecast_repository.dart';
import 'package:weather_app/core/domain/repositories/weather_repository.dart';
import 'package:weather_app/core/domain/use_cases/get_daily_forecast_useCase.dart';
import 'package:weather_app/core/presentation/detail_page/detail_bloc/detail_bloc.dart';
import 'package:weather_app/core/presentation/settings/bloc/frequency/frequency_bloc.dart';
import 'package:weather_app/core/presentation/settings/bloc/temperature/temperature_bloc.dart';
import 'package:weather_app/core/presentation/settings/settings_bloc/settings_bloc.dart';

import 'core/data/api_service.dart';
import 'core/data/interceptors/dio_interceptor.dart';
import 'core/data/repositories/app_flavor_repository_imp.dart';
import 'core/data/repositories/app_setting_repository_imp.dart';
import 'core/data/repositories/forecast_repository_imp.dart';
import 'core/data/repositories/location_repository.dart';
import 'core/data/repositories/weather_repository_imp.dart';
import 'core/domain/repositories/app_flavor_repository.dart';
import 'core/domain/repositories/app_setting_repository.dart';
import 'core/domain/repositories/location_repository.dart';
import 'core/domain/use_cases/get_weather_details_useCase.dart';
import 'core/domain/use_cases/search_location_usecase.dart';
import 'core/presentation/weather/weather_bloc/weather_bloc.dart';
import 'shared_prefs/SecureStorage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CancelToken());
  final dio = Dio();
  dio.interceptors.add(DioInterceptor());

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final SecureStorage secureStorage = SecureStorage(sharedPreferences: sl());
  sl.registerLazySingleton(() => secureStorage);

  sl.registerLazySingleton(
      () => ApiServiceDio(appFlavorRepository: sl(), dioService: dio));
  /**
   * UseCase
   */

  sl.registerLazySingleton(
      () => GetWeatherDetailsUseCase(weatherRepository: sl()));

  sl.registerLazySingleton(() => GetDailyForecastUseCase(
      forecastRepository: sl(), appSettingRepository: sl()));

  sl.registerLazySingleton(
      () => SearchLocationUseCase(locationRepository: sl()));

  /**
   * Repositories
   */

  sl.registerLazySingleton<AppFlavorRepository>(() => AppFlavorRepositoryImp());

  sl.registerLazySingleton<AppSettingRepository>(
      () => AppSettingRepositoryImp(secureStorage: sl()));

  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImp(apiService: sl()));

  sl.registerLazySingleton<ForecastRepository>(
      () => ForecastRepositoryImp(apiService: sl()));

  sl.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImp(apiService: sl(), appFlavorRepository: sl()));

  /**
   * Blocs
   */
  sl.registerFactory(
    () => WeatherBloc(
        searchLocationUseCase: sl(),
        getWeatherDetailsUseCase: sl(),
        appSettingRepository: sl(),
        cancelToken: sl()),
  );

  sl.registerFactory(
    () => DetailBloc(
      dailyForecastUseCase: sl(),
      appSettingRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => SettingsBloc(),
  );

  sl.registerFactory(
    () => TemperatureBloc(
      appSettingRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => FrequencyBloc(
      appSettingRepository: sl(),
    ),
  );
}
