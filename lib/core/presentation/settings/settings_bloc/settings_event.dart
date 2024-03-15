part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class GetSettingsEvent extends SettingsEvent {
  final Position location;

  GetSettingsEvent({required this.location});
}

abstract class TemperatureSettingsEvent {}

class GetTemperatureSettingsEvent extends TemperatureSettingsEvent {}

class UpdateCelsiusEvent extends TemperatureSettingsEvent {
  final bool isCelsiusSelected;

  UpdateCelsiusEvent({required this.isCelsiusSelected});
}

class UpdateFahrenheitEvent extends TemperatureSettingsEvent {
  final bool isFahrenheitSelected;

  UpdateFahrenheitEvent({required this.isFahrenheitSelected});
}
