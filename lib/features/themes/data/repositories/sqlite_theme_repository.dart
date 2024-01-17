import 'package:luciapp/features/themes/data/abstract_repositories/theme_repository.dart';

class SqLiteThemeRepository implements IThemeRepository {
  @override
  Future<bool> isDarkModeEnabled() {
    // TODO: implement isDarkModeEnabled
    throw UnimplementedError();
  }

  @override
  Future<bool> isHCModeEnabled() {
    // TODO: implement isHCModeEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> updateDarkMode(bool enabled) {
    // TODO: implement updateDarkMode
    throw UnimplementedError();
  }

  @override
  Future<void> updateHCMode(bool enabled) {
    // TODO: implement updateHCMode
    throw UnimplementedError();
  }
}
