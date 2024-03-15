part of 'frequency_bloc.dart';

abstract class FrequencyState {}

class FrequencySettingsInitial extends FrequencyState {}

class FrequencySettingsFetched extends FrequencyState {
  final bool isTenMinsFreqEnabled;
  final bool isThirtyMinsFreqEnabled;
  final bool isSixtyMinsFreqEnabled;

  FrequencySettingsFetched({
    required this.isTenMinsFreqEnabled,
    required this.isThirtyMinsFreqEnabled,
    required this.isSixtyMinsFreqEnabled,
  });
}

class FrequencyTenMinsUpdated extends FrequencyState {
  final bool isSelected;

  FrequencyTenMinsUpdated({
    required this.isSelected,
  });
}

class FrequencyThirtyMinsUpdated extends FrequencyState {
  final bool isSelected;

  FrequencyThirtyMinsUpdated({
    required this.isSelected,
  });
}

class FrequencySixtyMinsUpdated extends FrequencyState {
  final bool isSelected;

  FrequencySixtyMinsUpdated({
    required this.isSelected,
  });
}
