import 'dart:math';

double toCelsius(double kelvin) => kelvin - 273.15;

double toFahrenheit(double kelvin) => (kelvin - 273.15) * 9 / 5 + 32;

double calculateDistance(
    {required double lat1,
    required double lon1,
    required double lat2,
    required double lon2}) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
