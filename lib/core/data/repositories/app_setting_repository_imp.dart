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
}
