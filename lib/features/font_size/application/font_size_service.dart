import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/auth_repository.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/font_size/data/abstract_repositories/font_settings_repository.dart';
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';
import 'package:luciapp/features/font_size/presentation/state/font_size_state.dart';
import 'package:luciapp/main.dart';

class FontSizeService {
  final IFontSettingsRepository _fontSettingsRepository;
  final IAuthRepository _authRepository;

  FontSizeService({
    required IFontSettingsRepository fontSettingsRepository,
    required IAuthRepository authRepository,
  })  : _fontSettingsRepository = fontSettingsRepository,
        _authRepository = authRepository;

  Future<FontSizeState> getCurrentFontSizeState() async {
    final userId = _authRepository.userId;

    if (userId == null) {
      return const FontSizeState.initial();
    }

    final userFontSettings = await getOrCreateUserFontSettings(userId);

    return FontSizeState.fromUserFontSettings(userFontSettings);
  }

  Future<FontSizeState> increaseFontSize() async {
    final fontSizeState = await getCurrentFontSizeState();

    if (fontSizeState.canIncreaseSize) {
      final updatedState = fontSizeState.copyWithScaleFactor(
        fontSizeState.scaleFactor + .1,
      );

      final userId = _authRepository.userId;

      if (userId == null) {
        return const FontSizeState.initial();
      }

      await _fontSettingsRepository.update(UserFontSettings(
          scaleFactor: updatedState.scaleFactor, userId: userId));

      log("increased to: ");
      log(updatedState.scaleFactor.toString());

      return updatedState;
    }

    return fontSizeState;
  }

  Future<FontSizeState> decreaseFontSize() async {
    final fontSizeState = await getCurrentFontSizeState();

    if (fontSizeState.canDecreaseSize) {
      final updatedState = fontSizeState.copyWithScaleFactor(
        fontSizeState.scaleFactor - .1,
      );

      final userId = _authRepository.userId;

      if (userId == null) {
        return const FontSizeState.initial();
      }

      await _fontSettingsRepository.update(UserFontSettings(
          scaleFactor: updatedState.scaleFactor, userId: userId));

      log("decreased to: ");
      log(updatedState.scaleFactor.toString());

      return updatedState;
    }

    return fontSizeState;
  }

  Future<UserFontSettings> getOrCreateUserFontSettings(UserId userId) async {
    final userFontSettings = await _fontSettingsRepository.get(userId);

    if (userFontSettings == null) {
      return await _fontSettingsRepository
          .create(UserFontSettings.initial(userId));
    } else {
      return userFontSettings;
    }
  }
}

final fontSizeServiceProvider = Provider<FontSizeService>((ref) {
  return FontSizeService(
      fontSettingsRepository: ref.watch(fontSettingsRepositoryProvider),
      authRepository: ref.watch(authRepositoryProvider));
});
