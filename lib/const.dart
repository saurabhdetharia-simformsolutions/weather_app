import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Default Abu Dhabi location
const defaultLat = 24.4539;
const defaultLong = 54.3773;

var defaultPosition = Position(
  longitude: defaultLong,
  latitude: defaultLat,
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
const keyLat = 'LATITUDE';
const keyLong = 'LONGITUDE';
const key10MinFreq = 'TEN_MIN_FREQ';
const key30MinFreq = 'THIRTY_MIN_FREQ';
const key60MinFreq = 'SIXTY_MIN_FREQ';
const keyLastOpenTime = 'LAST_APP_ACCESS_TIME';
const keyDailyForecast = 'DAILY_FORECAST';

/// To convert temp into cel or fer
///
/// This will be used globally
bool isCelsius = true;


final shimmerColor = Colors.lightBlueAccent.withOpacity(0.15);
