part of 'settings_bloc.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsFetched extends SettingsState {
  final bool shouldShowCelsius;
  final bool shouldShowFahrenheit;

  SettingsFetched({
    required this.shouldShowCelsius,
    required this.shouldShowFahrenheit,
  });
}

abstract class TemperatureSettingsState {}

class TemperatureSettingsInitial extends TemperatureSettingsState {}

class TemperatureSettingsFetched extends TemperatureSettingsState {
  final bool shouldShowCelsius;
  final bool shouldShowFahrenheit;

  TemperatureSettingsFetched({
    required this.shouldShowCelsius,
    required this.shouldShowFahrenheit,
  });
}

class FahrenheitUpdated extends TemperatureSettingsState {
  final bool isSelected;

  FahrenheitUpdated({
    required this.isSelected,
  });
}

class CelsiusUpdated extends TemperatureSettingsState {
  final bool isSelected;

  CelsiusUpdated({
    required this.isSelected,
  });
}
