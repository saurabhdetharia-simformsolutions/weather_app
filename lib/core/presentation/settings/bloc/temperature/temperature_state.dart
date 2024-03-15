part of 'temperature_bloc.dart';

abstract class TemperatureState {}

class TemperatureSettingsInitial extends TemperatureState {}

class TemperatureSettingsFetched extends TemperatureState {
  final bool shouldShowCelsius;
  final bool shouldShowFahrenheit;

  TemperatureSettingsFetched({
    required this.shouldShowCelsius,
    required this.shouldShowFahrenheit,
  });
}

class FahrenheitUpdated extends TemperatureState {
  final bool isSelected;

  FahrenheitUpdated({
    required this.isSelected,
  });
}

class CelsiusUpdated extends TemperatureState {
  final bool isSelected;

  CelsiusUpdated({
    required this.isSelected,
  });
}
