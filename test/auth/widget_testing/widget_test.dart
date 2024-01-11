import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/common/providers/is_loading_provider.dart';
import 'package:luciapp/features/auth/data/auth_repository.dart';
import 'package:luciapp/features/auth/data/providers/auth_result_provider.dart';
import 'package:luciapp/features/auth/data/providers/user_display_name_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';

import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late final MockAuthRepository authRepository;
  setUpAll(() async {
    authRepository = MockAuthRepository();
  });

  group(
    "(Integration Test)",
    () {
      testWidgets('[CP-024] When user is not authenticated',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authResultProvider.overrideWith((ref) => AuthResult.failure),
              isLoadingProvider.overrideWith((ref) => false),
            ],
            child: const MyApp(),
          ),
        );

        final authPage = find.byKey(Keys.authPage);

        expect(authPage, findsOne);
      });

      testWidgets('[CP-025] When user is authenticated',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWith((ref) => authRepository),
              authResultProvider.overrideWith((ref) => AuthResult.success),
              isLoadingProvider.overrideWith((ref) => false),
            ],
            child: const MyApp(),
          ),
        );

        final homePage = find.byKey(Keys.homePage);

        expect(homePage, findsOne);
      });

      testWidgets('[CP-026] When user is authenticated but not registered',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWith((ref) => authRepository),
              authResultProvider.overrideWith((ref) => AuthResult.registering),
              userDisplayNameProvider.overrideWith((ref) => 'hola'),
              isLoadingProvider.overrideWith((ref) => true),
            ],
            child: const MyApp(),
          ),
        );

        final authPage = find.byKey(Keys.authPage);
        final registerForm = find.byKey(Keys.registerForm);

        expect(authPage, findsOne);
        expect(registerForm, findsOne);
      });

      testWidgets('[CP-027] When user is authenticated but not registered',
          (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWith((ref) => authRepository),
              authResultProvider.overrideWith((ref) => AuthResult.registering),
              userDisplayNameProvider.overrideWith((ref) => null),
              isLoadingProvider.overrideWith((ref) => true),
            ],
            child: const MyApp(),
          ),
        );

        final authPage = find.byKey(Keys.authPage);
        final registerForm = find.byKey(Keys.registerForm);
        final registerButton = find.byKey(Keys.registerButton);

        expect(authPage, findsOne);
        expect(registerForm, findsOne);

        await tester.tap(registerButton);
        await tester.pump(const Duration(seconds: 1));
        expect(find.text("Debes ingresar tu edad"), findsAny);
        expect(find.text("Debes seleccionar un genero"), findsAny);
        expect(find.text("Debes ingresar tu nombre"), findsAny);
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

// Checks that tappable nodes have a minimum size of 44 by 44 pixels
// for iOS.
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

// Checks that touch targets with a tap or long press action are labeled.
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

// Checks whether semantic nodes meet the minimum text contrast levels.
// The recommended text contrast is 3:1 for larger text
// (18 point and above regular).
        await expectLater(tester, meetsGuideline(textContrastGuideline));

        handle.dispose();
      });
    },
  );
}
