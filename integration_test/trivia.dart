import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/themes/themes.dart';
import 'package:luciapp/features/games/data/abstract_repositories/game_levels_repositoryl.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/enums/game_type.dart';
import 'package:luciapp/features/games/domain/models/trivia_level.dart';
import 'package:luciapp/features/games/presentation/trivia_screen.dart';
import 'package:luciapp/features/themes/data/providers/theme_mode_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../test/games/constants/strings.dart';

class MockLevelsRepository extends Mock implements IGameLevelsRepository {}

const imageUrl =
    'https://firebasestorage.googleapis.com/v0/b/project-luciapp.appspot.com/o/courses%2F3JpGUu0qD7nfC2F1f1yf%2Fgame_images%2Flas%20flores.png?alt=media&token=b36ec641-4cd1-4697-90b8-8d40054ff545';

void main() {
  late MockLevelsRepository mocklevelsRepository;
  const gameId = '1234';
  final List<TriviaLevel> levels = [
    TriviaLevel(
        question: 'Es cierto que',
        answer: true,
        imagePath: imageUrl,
        explaination: 'Es cierto porque')
  ];

  setUpAll(() {
    mocklevelsRepository = MockLevelsRepository();
  });

  final overrides = [
    gameLevelsRepositoryProvider.overrideWith((ref) => mocklevelsRepository),
    themeModeProvider.overrideWithValue(AppThemeMode.light),
  ];

  HttpOverrides.runZoned(() async {
    ///
    ///
    group(TestNames.integrationTest, () {
      testWidgets(TestNames.cp076, (tester) async {
        when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
            .thenAnswer((invocation) => Future.value(levels));

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: overrides,
              child: MaterialApp(
                theme: themes[AppThemeMode.hcDark],
                home: TriviaGame(
                  levels: levels,
                  mode: GameMode.custom,
                ),
              ),
            ),
          );
        });

        final falseButton = find.byKey(const ValueKey('false-button'));
        final trueButton = find.byKey(const ValueKey('true-button'));

        expect(falseButton, findsOne);
        expect(trueButton, findsOne);
        expect(find.text(levels.first.question), findsOne);
      });

      testWidgets(TestNames.cp077, (tester) async {
        when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
            .thenAnswer((invocation) => Future.value(levels));

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: overrides,
              child: MaterialApp(
                theme: themes[AppThemeMode.hcDark],
                home: TriviaGame(
                  levels: levels,
                  mode: GameMode.custom,
                ),
              ),
            ),
          );
        });

        final falseButton = find.byKey(const ValueKey('false-button'));
        final trueButton = find.byKey(const ValueKey('true-button'));

        expect(falseButton, findsOne);
        expect(trueButton, findsOne);
        expect(find.text(levels.first.question), findsOne);

        await tester.runAsync(() async {
          await tester.tap(trueButton);
        });
        await tester.pumpAndSettle();
      });
      testWidgets(TestNames.cp078, (tester) async {
        when(() => mocklevelsRepository.getAll(gameId, GameType.hangman))
            .thenAnswer((invocation) => Future.value(levels));

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: overrides,
              child: MaterialApp(
                theme: themes[AppThemeMode.hcDark],
                home: TriviaGame(
                  levels: levels,
                  mode: GameMode.custom,
                ),
              ),
            ),
          );
        });

        final falseButton = find.byKey(const ValueKey('false-button'));
        final trueButton = find.byKey(const ValueKey('true-button'));

        expect(falseButton, findsOne);
        expect(trueButton, findsOne);
        expect(find.text(levels.first.question), findsOne);

        await tester.runAsync(() async {
          await tester.tap(falseButton);
        });
        await tester.pumpAndSettle();
      });
    });
  }, createHttpClient: (c) => HttpClient(context: c));
}
