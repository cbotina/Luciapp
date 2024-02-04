import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/font_size/application/font_size_service.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/features/font_size/presentation/state/font_size_state.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_font_size_service.dart';

void main() {
  late MockFontSizeService mockFontSizeService;
  late ProviderContainer container;

  setUp(() {
    mockFontSizeService = MockFontSizeService();
  });

  ProviderContainer makeProviderContainer(MockFontSizeService fontSizeService) {
    final container = ProviderContainer(
      overrides: [
        fontSizeServiceProvider.overrideWithValue(fontSizeService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group("Unit Testing", () {
    test("When text increases and doesn't reach the limit", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initialState = FontSizeState.initial();

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState = initialState.copyWithScaleFactor(1.1);

      final controller = container.read(fontSizeControllerProvider.notifier);

      when(mockFontSizeService.increaseFontSize)
          .thenAnswer((invocation) => Future.value(finalState));

      await controller.increaseFontSize();

      expect(controller.state, AsyncData(finalState));
    });
    test("When text increases and reaches the limit", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initalScaleFactor = 1.9;
      const initialState = FontSizeState.fromScaleFactor(initalScaleFactor);

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState =
          initialState.copyWithScaleFactor(initalScaleFactor + .1);

      final controller = container.read(fontSizeControllerProvider.notifier);

      when(mockFontSizeService.increaseFontSize)
          .thenAnswer((invocation) => Future.value(finalState));

      await controller.increaseFontSize();

      expect(controller.state, AsyncData(finalState));
      expect(controller.state.value!.canIncreaseSize, false);
    });

    test("When text doesn't increase its size", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initalScaleFactor = 2.0;
      const initialState = FontSizeState.fromScaleFactor(initalScaleFactor);

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState = initialState.copyWithScaleFactor(initalScaleFactor);

      final controller = container.read(fontSizeControllerProvider.notifier);

      when(mockFontSizeService.increaseFontSize)
          .thenAnswer((invocation) => Future.value(finalState));

      await controller.increaseFontSize();

      expect(controller.state, const AsyncData(initialState));
      expect(controller.state.value!.canIncreaseSize, false);
    });

    test("When text decreases and doesn't reach the limit", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initialScaleFactor = 1.0;

      const initialState = FontSizeState.fromScaleFactor(initialScaleFactor);

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState =
          initialState.copyWithScaleFactor(initialScaleFactor - .1);

      final controller = container.read(fontSizeControllerProvider.notifier);

      when(mockFontSizeService.decreaseFontSize)
          .thenAnswer((invocation) => Future.value(finalState));

      await controller.decreaseFontSize();

      expect(controller.state, AsyncData(finalState));
    });
    test("When text decreases and reaches the limit", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initalScaleFactor = .9;
      const initialState = FontSizeState.fromScaleFactor(initalScaleFactor);

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState =
          initialState.copyWithScaleFactor(initalScaleFactor - .1);

      final controller = container.read(fontSizeControllerProvider.notifier);

      when(mockFontSizeService.decreaseFontSize)
          .thenAnswer((invocation) => Future.value(finalState));

      await controller.decreaseFontSize();

      expect(controller.state, AsyncData(finalState));
      expect(controller.state.value!.canDecreaseSize, false);
    });

    test("When text doesn't decrease its size", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initalScaleFactor = .8;
      const initialState = FontSizeState.fromScaleFactor(initalScaleFactor);

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState = initialState.copyWithScaleFactor(initalScaleFactor);

      final controller = container.read(fontSizeControllerProvider.notifier);

      when(mockFontSizeService.decreaseFontSize)
          .thenAnswer((invocation) => Future.value(finalState));

      await controller.decreaseFontSize();

      expect(controller.state, const AsyncData(initialState));
      expect(controller.state.value!.canDecreaseSize, false);
    });

    test("refresh", () async {
      container = makeProviderContainer(mockFontSizeService);

      const initalScaleFactor = .8;
      const initialState = FontSizeState.fromScaleFactor(initalScaleFactor);

      when(mockFontSizeService.getCurrentFontSizeState)
          .thenAnswer((invocation) => Future.value(initialState));

      final finalState = initialState.copyWithScaleFactor(initalScaleFactor);

      final controller = container.read(fontSizeControllerProvider.notifier);

      await controller.refresh();

      expect(controller.state, AsyncData(finalState));
    });
  });
}
