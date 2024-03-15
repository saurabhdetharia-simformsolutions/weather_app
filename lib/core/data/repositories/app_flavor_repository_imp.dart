import '../../domain/repositories/app_flavor_repository.dart';

class AppFlavorRepositoryImp implements AppFlavorRepository {
  @override
  String getBaseUrl() {
    return 'api.openweathermap.org';
  }

  @override
  String getSearchLocationBaseUrl() {
   return 'geocoding-api.open-meteo.com';
  }
}
