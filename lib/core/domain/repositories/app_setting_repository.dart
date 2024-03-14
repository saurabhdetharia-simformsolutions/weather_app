import '../../data/models/current_weather/current_weather_res.dart';

abstract class AppSettingRepository {
  void saveUserInfoInTable(List<CurrentWeatherRes> users);

  List<dynamic> getUserFromPref();
}
