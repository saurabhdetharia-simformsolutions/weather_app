part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class GetSettingsEvent extends SettingsEvent {
  final Position location;

  GetSettingsEvent({required this.location});
}



