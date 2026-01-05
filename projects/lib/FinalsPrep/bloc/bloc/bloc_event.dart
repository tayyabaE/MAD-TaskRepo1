
import 'package:equatable/equatable.dart';

abstract class BikeEvent extends Equatable{
  const BikeEvent();

  @override
  List<Object?> get props => [];
}

class FetchBikesEvent extends BikeEvent{}