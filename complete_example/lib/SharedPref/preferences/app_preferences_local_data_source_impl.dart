
import 'package:shared_preferences/shared_preferences.dart';
import 'package:complete_example/SharedPref/preferences/app_pref_local_data_source.dart';

class AppPreferencesLocalDataSourceImpl implements AppPreferencesLocalDataSource {
  static const String modeKey = 'isDarkMode';

  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(modeKey, isDarkMode);
  }

  @override
  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(modeKey) ?? false;
  }
}