import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/domain/repositories/weather_repository.dart';

import 'core/data/api_service.dart';
import 'core/data/interceptors/dio_interceptor.dart';
import 'core/data/repositories/app_flavor_repository_imp.dart';
import 'core/data/repositories/app_setting_repository_imp.dart';
import 'core/data/repositories/weather_repository_imp.dart';
import 'core/domain/repositories/app_flavor_repository.dart';
import 'core/domain/repositories/app_setting_repository.dart';
import 'core/domain/use_cases/get_weather_details_useCase.dart';
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

  sl.registerLazySingleton(() => GetWeatherDetailsUseCase(
      weatherRepository: sl(), appSettingRepository: sl()));

  // sl.registerLazySingleton(() =>
  //     GetUserDetailUseCase(userRepository: sl(), appSettingRepository: sl()));

  /**
   * Repositories
   */

  sl.registerLazySingleton<AppFlavorRepository>(() => AppFlavorRepositoryImp());

  sl.registerLazySingleton<AppSettingRepository>(
          () => AppSettingRepositoryImp(secureStorage: sl()));

  sl.registerLazySingleton<WeatherRepository>(
          () => WeatherRepositoryImp(apiService: sl()));

  /**
   * Blocs
   */
  sl.registerFactory(
        () => WeatherBloc(
      getWeatherDetailsUseCase: sl(),
    ),
  );
}
