import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/common/constants/widget_keys.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart'
    as auth;

class TestingRobot {
  final WidgetTester tester;

  final genderDropdown = find.byKey(auth.Keys.genderDropdownButton);
  final nameFormField = find.byKey(auth.Keys.nameTextFormField);
  final ageFormField = find.byKey(auth.Keys.ageTextFormField);
  final registerButton = find.byKey(auth.Keys.registerButton);
  final googleButton = find.byKey(auth.Keys.googleButton);
  final logoutIconButton = find.byKey(auth.Keys.logoutIconButton);
  final mainPage = find.byKey(Keys.mainPage);
  final accessibilityPage = find.byKey(Keys.accessibilityPage);

  TestingRobot({required this.tester});

  Future<void> enterName(String name) async {
    await tester.enterText(nameFormField, name);
  }

  Future<void> enterAge(int age) async {
    await tester.enterText(ageFormField, age.toString());
  }

  Future<void> selectGender() async {
    final coordinates = tester.getCenter(genderDropdown);
    await tester.tap(genderDropdown);
    await tester.tapAt(coordinates);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tapAt(coordinates);
    await tester.pump(const Duration(milliseconds: 100));
  }

  Future<void> pressRegisterButton() async {
    await tester.tap(nameFormField);
    await tester.tap(registerButton, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 100));
  }

  Future<void> login() async {
    await tester.tap(googleButton);
    await tester.pump(const Duration(milliseconds: 100));
  }

  Future<void> pressLogoutIconButton() async {
    await tester.tap(logoutIconButton);
    await tester.pump(const Duration(milliseconds: 100));
  }

  Future<void> goToAccessibilityPage() async {
    await tester.dragUntilVisible(
      accessibilityPage,
      mainPage,
      const Offset(-300, 0),
      duration: const Duration(milliseconds: 500),
    );
  }
}
