import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../const.dart';
import '../../../../domain/repositories/app_setting_repository.dart';

part 'temperature_event.dart';

part 'temperature_state.dart';

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {
  final AppSettingRepository appSettingRepository;

  TemperatureBloc({required this.appSettingRepository})
      : super(TemperatureSettingsInitial()) {
    on<GetTemperatureSettingsEvent>(_fetchSettings);
    on<UpdateFahrenheitEvent>(_updateFahrenhit);
    on<UpdateCelsiusEvent>(_updateCelsius);
  }

  FutureOr<void> _updateFahrenhit(
      UpdateFahrenheitEvent event, Emitter<TemperatureState> emit) {
    appSettingRepository.saveShowFahrenheit(event.isFahrenheitSelected);
    appSettingRepository.saveShowCelsius(!event.isFahrenheitSelected);
    isCelsius = !event.isFahrenheitSelected;
    emit(FahrenheitUpdated(isSelected: event.isFahrenheitSelected));
  }

  FutureOr<void> _updateCelsius(
      UpdateCelsiusEvent event, Emitter<TemperatureState> emit) {
    appSettingRepository.saveShowCelsius(event.isCelsiusSelected);
    appSettingRepository.saveShowFahrenheit(!event.isCelsiusSelected);
    isCelsius = event.isCelsiusSelected;
    emit(CelsiusUpdated(isSelected: event.isCelsiusSelected));
  }

  FutureOr<void> _fetchSettings(
      GetTemperatureSettingsEvent event, Emitter<TemperatureState> emit) {
    bool shouldShowFahrenheit = appSettingRepository.shouldShowFahrenheit();
    bool shouldShowCelsius = appSettingRepository.shouldShowCelsius();

    emit(TemperatureSettingsFetched(
      shouldShowCelsius: !shouldShowCelsius && !shouldShowFahrenheit
          ? true
          : shouldShowCelsius,
      shouldShowFahrenheit: shouldShowFahrenheit,
    ));
  }
}
