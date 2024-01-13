import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/widget_keys.dart';

class RegisterRobot {
  final WidgetTester tester;

  final genderDropdown = find.byKey(Keys.genderDropdownButton);
  final nameFormField = find.byKey(Keys.nameTextFormField);
  final ageFormField = find.byKey(Keys.ageTextFormField);
  final registerButton = find.byKey(Keys.registerButton);

  RegisterRobot({required this.tester});

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
}
