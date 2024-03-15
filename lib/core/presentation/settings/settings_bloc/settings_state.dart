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


abstract class FrequencySettingsState {}

class FrequencySettingsInitial extends FrequencySettingsState {}

class FrequencySettingsFetched extends FrequencySettingsState {
  final bool isTenMinsFreqEnabled;
  final bool isThirtyMinsFreqEnabled;
  final bool isSixtyMinsFreqEnabled;

  FrequencySettingsFetched({
    required this.isTenMinsFreqEnabled,
    required this.isThirtyMinsFreqEnabled,
    required this.isSixtyMinsFreqEnabled,
  });
}

class FrequencyTenMinsUpdated extends FrequencySettingsState {
  final bool isSelected;

  FrequencyTenMinsUpdated({
    required this.isSelected,
  });
}

class FrequencyThirtyMinsUpdated extends FrequencySettingsState {
  final bool isSelected;

  FrequencyThirtyMinsUpdated({
    required this.isSelected,
  });
}

class FrequencySixtyMinsUpdated extends FrequencySettingsState {
  final bool isSelected;

  FrequencySixtyMinsUpdated({
    required this.isSelected,
  });
}
