import 'package:equatable/equatable.dart';

abstract class AlertEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAlertsEvent extends AlertEvent {}
