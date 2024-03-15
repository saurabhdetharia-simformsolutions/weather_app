import '../../data/models/current_weather/current_weather_res.dart';

abstract class AppSettingRepository {
  void saveUserInfoInTable(List<CurrentWeatherRes> users);

  /// Temperature
  void saveShowFahrenheit(bool isSelected);
  bool shouldShowFahrenheit();
  void saveShowCelsius(bool isSelected);
  bool shouldShowCelsius();

  /// Weather info
  void saveWeatherInfo(String weatherInfo);
  String getWeatherInfo();

  /// Daily forecast info
  void saveDailyForecastInfo(String dailyForecastInfo);
  String getDailyForecastInfo();

  /// Lat - long
  double getLat();
  double getLong();
  void setLat(String lat);
  void setLong(String long);

  /// Frequency
  void shouldEnableTenMins(bool isSelected);
    bool isTenMinsEnabled();
    void shouldEnableThirtyMins(bool isSelected);
    bool isThirtyMinsEnabled();
    void shouldEnableSixtyyMins(bool isSelected);
    bool isSixtyMinsEnabled();

  /// Last app open time
  void saveLastOpenTime(String dateTime);
  String getLastOpenTime();

  List<dynamic> getUserFromPref();
}
