import '../models/weather_alert.dart';

class WeatherRepository {
  Future<List<WeatherAlert>> getActiveAlerts() async {
    // simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    return [
      WeatherAlert(title: "Heavy Rain"),
      WeatherAlert(title: "Fog"),
      WeatherAlert(title: "Heatwave"),
    ];
  }
}
