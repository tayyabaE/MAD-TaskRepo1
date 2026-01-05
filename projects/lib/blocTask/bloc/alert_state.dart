import 'package:equatable/equatable.dart';
import '../models/weather_alert.dart';

abstract class AlertState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class AlertInitial extends AlertState {}

// Loading State
class AlertLoading extends AlertState {}

// Loaded State
class AlertLoaded extends AlertState {
  final List<WeatherAlert> alerts;

  AlertLoaded(this.alerts);

  @override
  List<Object?> get props => [alerts];
}
