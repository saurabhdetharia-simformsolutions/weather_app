import 'package:weather_app/const.dart';
import 'package:weather_app/core/data/models/current_weather/current_weather_res.dart';

import '../../../shared_prefs/SecureStorage.dart';
import '../../domain/repositories/app_setting_repository.dart';

class AppSettingRepositoryImp implements AppSettingRepository {
  SecureStorage secureStorage;
  String defaultEmptyMapString = "{}";

  AppSettingRepositoryImp({required this.secureStorage});

  @override
  List getUserFromPref() {
    // TODO: implement getUserFromPref
    throw UnimplementedError();
  }

  @override
  void saveUserInfoInTable(List<CurrentWeatherRes> users) {
    // TODO: implement saveUserInfoInTable
  }

  @override
  void saveShowCelsius(bool isSelected) {
    secureStorage.setBoolean(keyIsCelsiusSelected, isSelected);
  }

  @override
  void saveShowFahrenheit(bool isSelected) {
    secureStorage.setBoolean(keyIsFahrenheitSelected, isSelected);
  }

  @override
  bool shouldShowCelsius() {
    return secureStorage.getBoolean(keyIsCelsiusSelected);
  }

  @override
  bool shouldShowFahrenheit() {
    return secureStorage.getBoolean(keyIsFahrenheitSelected);
  }

  @override
  String getWeatherInfo() {
    return secureStorage.getString(keyWeatherInfo);
  }

  @override
  void saveWeatherInfo(String weatherInfo) {
    secureStorage.setString(keyWeatherInfo, weatherInfo);
  }

  @override
  double getLat() {
    // TODO: implement getLat
    throw UnimplementedError();
  }

  @override
  double getLong() {
    // TODO: implement getLong
    throw UnimplementedError();
  }

  @override
  void setLat(double lat) {
    // TODO: implement setLat
  }

  @override
  void setLong(double long) {
    // TODO: implement setLong
  }
}
