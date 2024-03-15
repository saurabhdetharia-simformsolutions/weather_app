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
    return secureStorage.getBoolean(keyIsCelsiusSelected, true);
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
    return double.tryParse(secureStorage.getString(keyLat)) ?? 0;
  }

  @override
  double getLong() {
    return double.tryParse(secureStorage.getString(keyLong)) ?? 0;
  }

  @override
  void setLat(String lat) {
    secureStorage.setString(keyLat, lat.toString());
  }

  @override
  void setLong(String long) {
    secureStorage.setString(keyLong, long.toString());
  }

  @override
  bool isSixtyMinsEnabled() {
    return secureStorage.getBoolean(key60MinFreq);
  }

  @override
  bool isTenMinsEnabled() {
    return secureStorage.getBoolean(key10MinFreq, true);
  }

  @override
  bool isThirtyMinsEnabled() {
    return secureStorage.getBoolean(key30MinFreq);
  }

  @override
  void shouldEnableSixtyyMins(bool isSelected) {
    secureStorage.setBoolean(key60MinFreq, isSelected);
  }

  @override
  void shouldEnableTenMins(bool isSelected) {
    secureStorage.setBoolean(key10MinFreq, isSelected);
  }

  @override
  void shouldEnableThirtyMins(bool isSelected) {
    secureStorage.setBoolean(key30MinFreq, isSelected);
  }

  @override
  String getLastOpenTime() {
    return secureStorage.getString(keyLastOpenTime);
  }

  @override
  void saveLastOpenTime(String dateTime) {
    secureStorage.setString(keyLastOpenTime, dateTime);
  }

  @override
  String getDailyForecastInfo() {
    return secureStorage.getString(keyDailyForecast);
  }

  @override
  void saveDailyForecastInfo(String dailyForecastInfo) {
    secureStorage.setString(keyDailyForecast, dailyForecastInfo);
  }
}
