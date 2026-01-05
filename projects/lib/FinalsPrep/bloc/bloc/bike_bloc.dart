
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/FinalsPrep/bloc/bloc/bloc_event.dart';
import 'package:projects/FinalsPrep/bloc/bloc/bloc_state.dart';
import 'package:projects/FinalsPrep/bloc/repository/bike_repository.dart';

class BikeBloc extends Bloc<BikeEvent, BikeState>{
  final BikeRepository repo;

  BikeBloc({required this.repo}) : super(BikeInitial()){
    on<FetchBikesEvent>(_onFetchBike);
  }

  Future<void> _onFetchBike(FetchBikesEvent e, Emitter<BikeState> emit) async{
    emit(BikeLoading());
    final bikes = await repo.getBikes();
    emit(BikeLoaded(bikes));
  }
}