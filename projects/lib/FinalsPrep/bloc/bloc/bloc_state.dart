import 'package:projects/FinalsPrep/bloc/model/bike.dart';
import 'package:equatable/equatable.dart';

abstract class BikeState extends Equatable{
  const BikeState();

  @override
  List<Object?> get props => [];
}

class BikeInitial extends BikeState{}
class BikeLoading extends BikeState{}
class BikeLoaded extends BikeState{
  final List<Bike> bikes;
  const BikeLoaded(this.bikes);

  @override
  List<Object?> get props => [bikes];
}