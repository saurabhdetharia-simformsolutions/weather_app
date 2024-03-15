import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/app_setting_repository.dart';

part 'frequency_event.dart';

part 'frequency_state.dart';

class FrequencyBloc extends Bloc<FrequencyEvent, FrequencyState> {
  final AppSettingRepository appSettingRepository;

  FrequencyBloc({
    required this.appSettingRepository,
  }) : super(FrequencySettingsInitial()) {
    on<GetFrequencySettingsEvent>(_fetchFrequencySettings);
    on<UpdateTenMinsFreqEvent>(_updateTenMin);
    on<UpdateThirtyMinsFreqEvent>(_updateThirtyMin);
    on<UpdateSixtyMinsFreqEvent>(_updateSixtyMin);
  }

  FutureOr<void> _fetchFrequencySettings(
      GetFrequencySettingsEvent event, Emitter<FrequencyState> emit) {
    bool isTenMinsEnabled = appSettingRepository.isTenMinsEnabled();
    bool isThirtyMinsEnabled = appSettingRepository.isThirtyMinsEnabled();
    bool isSixtyMinsEnabled = appSettingRepository.isSixtyMinsEnabled();

    emit(FrequencySettingsFetched(
      isTenMinsFreqEnabled:
          !isTenMinsEnabled && !isThirtyMinsEnabled && !isSixtyMinsEnabled
              ? true
              : isTenMinsEnabled,
      isThirtyMinsFreqEnabled: isThirtyMinsEnabled,
      isSixtyMinsFreqEnabled: isSixtyMinsEnabled,
    ));
  }

  FutureOr<void> _updateTenMin(
      UpdateTenMinsFreqEvent event, Emitter<FrequencyState> emit) {
    appSettingRepository.shouldEnableTenMins(true);
    appSettingRepository.shouldEnableThirtyMins(false);
    appSettingRepository.shouldEnableSixtyyMins(false);
    emit(FrequencyTenMinsUpdated(isSelected: true));
  }

  FutureOr<void> _updateThirtyMin(
      UpdateThirtyMinsFreqEvent event, Emitter<FrequencyState> emit) {
    appSettingRepository.shouldEnableTenMins(false);
    appSettingRepository.shouldEnableThirtyMins(true);
    appSettingRepository.shouldEnableSixtyyMins(false);
    emit(FrequencyThirtyMinsUpdated(isSelected: true));
  }

  FutureOr<void> _updateSixtyMin(
      UpdateSixtyMinsFreqEvent event, Emitter<FrequencyState> emit) {
    appSettingRepository.shouldEnableTenMins(false);
    appSettingRepository.shouldEnableThirtyMins(false);
    appSettingRepository.shouldEnableSixtyyMins(true);
    emit(FrequencySixtyMinsUpdated(isSelected: true));
  }
}
