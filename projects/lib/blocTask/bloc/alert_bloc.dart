import 'package:flutter_bloc/flutter_bloc.dart';
import 'alert_event.dart';
import 'alert_state.dart';
import '../repository/weather_repository.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final WeatherRepository repository;

  AlertBloc(this.repository) : super(AlertInitial()) {
    on<FetchAlertsEvent>((event, emit) async {
      // Emit Loading
      emit(AlertLoading());

      // Fetch data from API
      final alerts = await repository.getActiveAlerts();

      // Emit Loaded
      emit(AlertLoaded(alerts));
    });
  }
}
