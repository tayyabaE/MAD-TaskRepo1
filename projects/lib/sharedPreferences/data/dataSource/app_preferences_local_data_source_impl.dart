import 'package:shared_preferences/shared_preferences.dart';
import 'app_preferences_local_data_source.dart';

class AppPreferencesLocalDataSourceImpl
    implements AppPreferencesLocalDataSource {

  static const String _quickAccessKey = 'quick_access_enabled';

  @override
  Future<void> enableQuickAccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quickAccessKey, true);
  }

  @override
  Future<void> disableQuickAccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quickAccessKey, false);
  }

  @override
  Future<bool> isQuickAccessEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_quickAccessKey) ?? false;
  }
}
