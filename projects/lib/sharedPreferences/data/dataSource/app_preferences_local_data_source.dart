abstract class AppPreferencesLocalDataSource {
  Future<void> enableQuickAccess();
  Future<void> disableQuickAccess();
  Future<bool> isQuickAccessEnabled();
}
