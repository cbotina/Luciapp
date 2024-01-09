// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
    "AuthResult",
    () {
      testWidgets('When user is not authenticated',
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authResultProvider.overrideWith((ref) => AuthResult.failure),
              isLoadingProvider.overrideWith((ref) => false),
            ],
            child: const MyApp(),
          ),
        );

        final authPage = find.byKey(const ValueKey(Keys.authPage));

        expect(authPage, findsOne);
      });

      testWidgets('When user is authenticated', (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authResultProvider.overrideWith((ref) => AuthResult.success),
              isLoadingProvider.overrideWith((ref) => false),
            ],
            child: const MyApp(),
          ),
        );

        final homePage = find.byKey(const ValueKey(Keys.homePage));

        expect(homePage, findsOne);
      });

      testWidgets('When user is authenticated but not registered',
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
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

        final authPage = find.byKey(const ValueKey(Keys.authPage));
        final registerForm = find.byKey(const ValueKey(Keys.registerForm));

        expect(authPage, findsOne);
        expect(registerForm, findsOne);
      });
    },
  );
}
