import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:luciapp/common/keys/widget_keys.dart';
import 'package:luciapp/common/providers/is_loading_provider.dart';
import 'package:luciapp/features/auth/data/providers/auth_result_provider.dart';
import 'package:luciapp/features/auth/data/providers/user_display_name_provider.dart';
import 'package:luciapp/features/auth/data/providers/user_id_provider.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/main.dart';
import 'package:mocktail/mocktail.dart';

import '../test/auth/mocks/mock_auth_controller.dart';
import '../test/auth/mocks/mock_auth_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late final MockAuthRepository mockAuthRepository;
  late final MockAuthController mockAuthController;

  setUpAll(() async {
    mockAuthRepository = MockAuthRepository();
    mockAuthController = MockAuthController();
  });

  testWidgets('[CP-024] When user is authenticated',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
          authResultProvider.overrideWith((ref) => AuthResult.success),
          isLoadingProvider.overrideWith((ref) => false),
        ],
        child: const MyApp(),
      ),
    );

    final homePage = find.byKey(Keys.homePage);

    expect(homePage, findsOne);
  });

  testWidgets('[CP-025] When user is authenticated but not registered',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
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

  testWidgets('[CP-026] When authentication fails',
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

  testWidgets('[CP-027] When authentication fails',
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

  testWidgets('[CP-028] Empty fields in form', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith((ref) => mockAuthController),
          authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
          authResultProvider.overrideWith((ref) => AuthResult.registering),
          userDisplayNameProvider.overrideWith((ref) => null),
          userIdProvider.overrideWith((ref) => '1234'),
          isLoadingProvider.overrideWith((ref) => true),
        ],
        child: const MyApp(),
      ),
    );

    final authPage = find.byKey(Keys.authPage);
    final registerForm = find.byKey(Keys.registerForm);

    expect(authPage, findsOne);
    log("AuthPage verified");
    expect(registerForm, findsOne);
    log("RegisterForm verified");

    final registerButton = find.byKey(Keys.registerButton);

    await tester.tap(registerButton);
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text("Debes ingresar tu edad"), findsAny);
    expect(find.text("Debes seleccionar un genero"), findsAny);
    expect(find.text("Debes ingresar tu nombre"), findsAny);

    final nameFormField = find.byKey(Keys.nameTextFormField);
    final ageFormField = find.byKey(Keys.ageTextFormField);
    final genderDropdown = find.byKey(Keys.genderDropdownButton);

    await tester.enterText(nameFormField, "Carlos");
    await tester.tap(registerButton);
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text("Debes ingresar tu edad"), findsAny);
    expect(find.text("Debes seleccionar un genero"), findsAny);
    expect(find.text("Debes ingresar tu nombre"), findsNothing);

    await tester.enterText(ageFormField, "21");
    await tester.tap(registerButton);
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text("Debes ingresar tu edad"), findsNothing);
    expect(find.text("Debes seleccionar un genero"), findsAny);
    expect(find.text("Debes ingresar tu nombre"), findsNothing);

    final coordinates = tester.getCenter(genderDropdown);
    log(coordinates.toString());
    await tester.tap(genderDropdown);
    await tester.tapAt(coordinates);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tapAt(coordinates);
    await tester.pump(const Duration(milliseconds: 100));

    when(() => mockAuthController.register(
            User(userId: '1234', name: 'Carlos', gender: Gender.male, age: 21)))
        .thenAnswer(
      (_) => Future.value(),
    );

    await tester.tap(nameFormField);
    await tester.tap(registerButton);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text("Debes ingresar tu edad"), findsNothing);
    expect(find.text("Debes seleccionar un genero"), findsNothing);
    expect(find.text("Debes ingresar tu nombre"), findsNothing);
  });

  testWidgets('[CP-028] Sucessful register', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith((ref) => mockAuthController),
          authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
          authResultProvider.overrideWith((ref) => AuthResult.registering),
          userDisplayNameProvider.overrideWith((ref) => null),
          userIdProvider.overrideWith((ref) => '1234'),
          isLoadingProvider.overrideWith((ref) => true),
        ],
        child: const MyApp(),
      ),
    );
    final user = User(
      userId: '1234',
      name: 'Carlos',
      gender: Gender.male,
      age: 21,
    );

    final registerButton = find.byKey(Keys.registerButton);
    final nameFormField = find.byKey(Keys.nameTextFormField);
    final ageFormField = find.byKey(Keys.ageTextFormField);
    final genderDropdown = find.byKey(Keys.genderDropdownButton);

    await tester.enterText(nameFormField, "Carlos");
    await tester.enterText(ageFormField, "21");
    final coordinates = tester.getCenter(genderDropdown);
    await tester.tap(genderDropdown);
    await tester.tapAt(coordinates);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tapAt(coordinates);
    await tester.pump(const Duration(milliseconds: 100));

    when(() => mockAuthController.register(user)).thenAnswer(
      (_) => Future.value(),
    );

    await tester.tap(nameFormField);
    await tester.tap(registerButton);
    await tester.pump(const Duration(seconds: 1));

    verify(() => mockAuthController.register(user)).called(2);
  });
}
