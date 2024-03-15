import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<GetSettingsEvent>(_onGetSettings);
  }

  Future<FutureOr<void>> _onGetSettings(
      GetSettingsEvent event, Emitter<SettingsState> emit) async {}
}

