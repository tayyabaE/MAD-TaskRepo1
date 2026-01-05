import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/alert_bloc.dart';
import 'bloc/alert_event.dart';
import 'bloc/alert_state.dart';
import 'repository/weather_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AlertBloc(WeatherRepository()),
        child: CityAlertsScreen(),
      ),
    );
  }
}

class CityAlertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("City Alerts")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AlertBloc>().add(FetchAlertsEvent());
            },
            child: const Text("Load Alerts"),
          ),
          Expanded(
            child: BlocBuilder<AlertBloc, AlertState>(
              builder: (context, state) {
                if (state is AlertLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AlertLoaded) {
                  return ListView.builder(
                    itemCount: state.alerts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.alerts[index].title),
                      );
                    },
                  );
                }
                return const Center(child: Text("No alerts loaded"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
