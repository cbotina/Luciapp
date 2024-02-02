import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/themes/application/theme_service.dart';
import 'package:luciapp/features/themes/presentation/controllers/theme_controller.dart';
import 'package:luciapp/features/themes/presentation/state/theme_state.dart';
import 'package:mocktail/mocktail.dart';

import '../constants/strings.dart';

class MockThemeService extends Mock implements ThemeService {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  late MockThemeService mockThemeService;
  late ProviderContainer container;
  setUp(() {
    mockThemeService = MockThemeService();
  });

  ProviderContainer makeProviderContainer(MockThemeService themeService) {
    final container = ProviderContainer(
      overrides: [
        themeServiceProvider.overrideWithValue(themeService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group(TestNames.unitTest, () {
    test(TestNames.cp032, () async {
      container = makeProviderContainer(mockThemeService);

      final initialState = ThemeState.light();

      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalstate = initialState.copyWithIsDarkModeEnabled(true);

      when(mockThemeService.toggleDarkMode).thenAnswer(
        (invocation) => Future.value(finalstate),
      );

      final themeController = container.read(themeControllerProvider.notifier);

      await themeController.toggleDarkMode();

      expect(themeController.state, AsyncData(finalstate));
    });

    test(TestNames.cp033, () async {
      container = makeProviderContainer(mockThemeService);

      final initialState = ThemeState.light();

      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalstate = initialState.copyWithIsHCModeEnabled(true);

      when(mockThemeService.toggleHCMode).thenAnswer(
        (invocation) => Future.value(finalstate),
      );

      final themeController = container.read(themeControllerProvider.notifier);

      await themeController.toggleHCMode();

      expect(themeController.state, AsyncData(finalstate));
    });

    test(TestNames.cp034, () async {
      container = makeProviderContainer(mockThemeService);

      final initialState = ThemeState.light();

      when(mockThemeService.getCurrentThemeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalstate = ThemeState.light();

      final themeController = container.read(themeControllerProvider.notifier);

      await themeController.refresh();

      expect(themeController.state, AsyncData(finalstate));
    });
  });
}
