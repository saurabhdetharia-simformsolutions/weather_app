import '../../data/models/current_weather/current_weather_res.dart';

abstract class AppSettingRepository {
  void saveUserInfoInTable(List<CurrentWeatherRes> users);

  void saveShowFahrenheit(bool isSelected);
  bool shouldShowFahrenheit();
  void saveShowCelsius(bool isSelected);
  bool shouldShowCelsius();
  void saveWeatherInfo(String weatherInfo);
  String getWeatherInfo();
  double getLat();
  double getLong();
  void setLat(double lat);
  void setLong(double long);

  List<dynamic> getUserFromPref();
}
