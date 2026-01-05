
abstract class AppPreferencesLocalDataSource {
  // Save theme mode: true = dark : false = light
  Future<void> saveDarkMode(bool isDarkMode);

  // Get save mode, default false
  Future<bool> getDarkMode();
}