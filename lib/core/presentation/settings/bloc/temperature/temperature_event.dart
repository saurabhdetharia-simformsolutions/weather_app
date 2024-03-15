part of 'temperature_bloc.dart';

abstract class TemperatureEvent {}

class GetTemperatureSettingsEvent extends TemperatureEvent {}

class UpdateCelsiusEvent extends TemperatureEvent {
  final bool isCelsiusSelected;

  UpdateCelsiusEvent({required this.isCelsiusSelected});
}

class UpdateFahrenheitEvent extends TemperatureEvent {
  final bool isFahrenheitSelected;

  UpdateFahrenheitEvent({required this.isFahrenheitSelected});
}
