import 'package:geolocator/geolocator.dart';

/// Default Abu Dhabi location
const defaultLat = 24.4539;
const defaultLong = 54.3773;

var defaultPosition = Position(
  longitude: defaultLat,
  latitude: defaultLong,
  timestamp: DateTime.now(),
  accuracy: 0,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

const keyIsFahrenheitSelected = 'IS_FAHRENHEIT_SELECTED';
const keyIsCelsiusSelected = 'IS_CELSIUS_SELECTED';
const keyWeatherInfo = 'WEATHER_INFO';

/// To convert temp into cel or fer
///
/// This will be used globally
bool isCelsius = true;