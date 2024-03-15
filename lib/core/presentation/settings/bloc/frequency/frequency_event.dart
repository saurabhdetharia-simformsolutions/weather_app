part of 'frequency_bloc.dart';

abstract class FrequencyEvent {}

class GetFrequencySettingsEvent extends FrequencyEvent {}

class UpdateTenMinsFreqEvent extends FrequencyEvent {
  final bool isTenMinFreqEnabled;

  UpdateTenMinsFreqEvent({required this.isTenMinFreqEnabled});
}

class UpdateThirtyMinsFreqEvent extends FrequencyEvent {
  final bool isThirtyMinFreqEnabled;

  UpdateThirtyMinsFreqEvent({required this.isThirtyMinFreqEnabled});
}

class UpdateSixtyMinsFreqEvent extends FrequencyEvent {
  final bool isSixtyMinFreqEnabled;

  UpdateSixtyMinsFreqEvent({required this.isSixtyMinFreqEnabled});
}
