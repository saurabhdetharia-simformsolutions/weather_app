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