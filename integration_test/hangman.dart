import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/themes/themes.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/hangman_level.dart';
import 'package:luciapp/features/games/presentation/hangman_screen.dart';
import 'package:luciapp/features/themes/data/providers/theme_mode_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';

import '../test/games/integration_testing/hangman_test.dart';

void main() {
  late MockLevelsRepository mocklevelsRepository;
  const gameId = '1234';
  final List<HangmanLevel> levels = [
    HangmanLevel('abc', 'world'),
  ];

  setUpAll(() {
    mocklevelsRepository = MockLevelsRepository();
  });

  final overrides = [
    gameLevelsRepositoryProvider.overrideWith((ref) => mocklevelsRepository),
    themeModeProvider.overrideWithValue(AppThemeMode.light),
  ];

  group('Integration Test', () {
    testWidgets('Level begins', (tester) async {
      when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
          .thenAnswer((invocation) => Future.value(levels));

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: MaterialApp(
            theme: themes[AppThemeMode.hcDark],
            home: HangmanGame(
              levels: levels,
              mode: GameMode.custom,
            ),
          ),
        ),
      );

      expect(find.byType(LetterField), findsNWidgets(levels.first.word.length));
    });

    testWidgets('User hits', (tester) async {
      when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
          .thenAnswer((invocation) => Future.value(levels));

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: MaterialApp(
            theme: themes[AppThemeMode.hcDark],
            home: HangmanGame(
              levels: levels,
              mode: GameMode.custom,
            ),
          ),
        ),
      );
      Finder letter(String letter) => find.byKey(ValueKey('letter-$letter'));

      final hangmanHead = find.byKey(const ValueKey('hangman-head'));

      expect(hangmanHead.hitTestable(), findsNothing);

      await tester.tap(letter('a'));
      await tester.pump(Durations.medium3);

      expect(hangmanHead.hitTestable(), findsNothing);
    });

    testWidgets('User fails', (tester) async {
      when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
          .thenAnswer((invocation) => Future.value(levels));

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: MaterialApp(
            theme: themes[AppThemeMode.hcDark],
            home: HangmanGame(
              levels: levels,
              mode: GameMode.custom,
            ),
          ),
        ),
      );
      Finder letter(String letter) => find.byKey(ValueKey('letter-$letter'));

      final hangmanHead = find.byKey(const ValueKey('hangman-head'));

      expect(hangmanHead.hitTestable(), findsNothing);

      await tester.tap(letter('a'));
      await tester.pump(Durations.medium3);

      expect(hangmanHead, findsOne);
    });
    testWidgets('User reaches fail limit', (tester) async {
      when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
          .thenAnswer((invocation) => Future.value(levels));

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: MaterialApp(
            theme: themes[AppThemeMode.hcDark],
            home: HangmanGame(
              levels: levels,
              mode: GameMode.custom,
            ),
          ),
        ),
      );
      Finder letter(String letter) => find.byKey(ValueKey('letter-$letter'));

      final hangmanLl = find.byKey(const ValueKey('hangman-head'));

      expect(hangmanLl.hitTestable(), findsNothing);

      await tester.tap(letter('e'));

      await tester.runAsync(() async {
        await tester.tap(letter('d'));
      });
      await tester.pumpAndSettle();

      expect(hangmanLl, findsOne);
    });
    testWidgets('User wins', (tester) async {
      when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
          .thenAnswer((invocation) => Future.value(levels));

      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides,
          child: MaterialApp(
            theme: themes[AppThemeMode.hcDark],
            home: HangmanGame(
              levels: levels,
              mode: GameMode.custom,
            ),
          ),
        ),
      );
      Finder letter(String letter) => find.byKey(ValueKey('letter-$letter'));

      final hangmanHead = find.byKey(const ValueKey('hangman-head'));

      expect(hangmanHead.hitTestable(), findsNothing);

      await tester.tap(letter('a'));
      await tester.pump(Durations.medium3);
      await tester.tap(letter('b'));
      await tester.pump(Durations.medium3);

      await tester.runAsync(() async {
        await tester.tap(letter('c'));
      });
      await tester.pumpAndSettle();
      final hangmanLl = find.byKey(const ValueKey('hangman-ll'));

      expect(hangmanLl.hitTestable(), findsNothing);
    });
  });
}
