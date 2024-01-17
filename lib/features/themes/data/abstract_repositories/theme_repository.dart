abstract class IThemeRepository {
  Future<bool> isDarkModeEnabled();
  Future<bool> isHCModeEnabled();
  Future<void> updateDarkMode(bool enabled);
  Future<void> updateHCMode(bool enabled);
}
