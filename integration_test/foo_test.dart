import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
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
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final authRepository = MockAuthRepository();
  testWidgets('tap on the floating action button, verify counter',
      (tester) async {
    // Load app widget.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => authRepository),
          authResultProvider.overrideWith((ref) => AuthResult.failure),
          userDisplayNameProvider.overrideWith((ref) => 'hola'),
          isLoadingProvider.overrideWith((ref) => true),
        ],
        child: const MyApp(),
      ),
    );

    final googleButton = find.byKey(const ValueKey(Keys.googleButton));

    await tester.tap(googleButton);

    expect(find.text('0'), findsNothing);
  });
}
