import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/repositories/app_setting_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<GetSettingsEvent>(_onGetSettings);
  }

  Future<FutureOr<void>> _onGetSettings(
      GetSettingsEvent event, Emitter<SettingsState> emit) async {}
}

class TemperatureBloc
    extends Bloc<TemperatureSettingsEvent, TemperatureSettingsState> {
  final AppSettingRepository appSettingRepository;

  TemperatureBloc({
    required this.appSettingRepository,
  }) : super(TemperatureSettingsInitial()) {
    on<GetTemperatureSettingsEvent>(_fetchSettings);
    on<UpdateFahrenheitEvent>(_updateFahrenhit);
    on<UpdateCelsiusEvent>(_updateCelsius);
  }

  FutureOr<void> _updateFahrenhit(
      UpdateFahrenheitEvent event, Emitter<TemperatureSettingsState> emit) {
    appSettingRepository.saveShowFahrenheit(event.isFahrenheitSelected);
    appSettingRepository.saveShowCelsius(!event.isFahrenheitSelected);
    emit(FahrenheitUpdated(isSelected: event.isFahrenheitSelected));
  }

  FutureOr<void> _fetchSettings(GetTemperatureSettingsEvent event,
      Emitter<TemperatureSettingsState> emit) {
    bool shouldShowFahrenheit = appSettingRepository.shouldShowFahrenheit();
    bool shouldShowCelsius = appSettingRepository.shouldShowCelsius();

    emit(TemperatureSettingsFetched(
      shouldShowCelsius: !shouldShowCelsius && !shouldShowFahrenheit
          ? true
          : shouldShowCelsius,
      shouldShowFahrenheit: shouldShowFahrenheit,
    ));
  }

  FutureOr<void> _updateCelsius(
      UpdateCelsiusEvent event, Emitter<TemperatureSettingsState> emit) {
    appSettingRepository.saveShowCelsius(event.isCelsiusSelected);
    appSettingRepository.saveShowFahrenheit(!event.isCelsiusSelected);
    emit(CelsiusUpdated(isSelected: event.isCelsiusSelected));
  }
}
