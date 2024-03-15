part of 'detail_bloc.dart';

abstract class DetailEvent {}

class GetDetailForecastEvent extends DetailEvent {
  final Position location;

  GetDetailForecastEvent({required this.location});
}
