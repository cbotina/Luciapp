import 'package:flutter/foundation.dart' show immutable, ValueKey;

@immutable
class Keys {
  static const facebookButton = ValueKey('facebook-button');
  static const googleButton = ValueKey('google-button');
  static const logoutButton = ValueKey('logout-button');
  static const logoutIconButton = ValueKey('logout-icon-button');
  static const registerButton = ValueKey('register-button');
  static const authPage = ValueKey('auth-page');
  static const homePage = ValueKey('home-page');
  static const registerForm = ValueKey('register-form');
  static const ageTextFormField = ValueKey('age-text-form-field');
  static const nameTextFormField = ValueKey('name-text-form-field');
  static const genderDropdownButton = ValueKey('gender-drop-down-button');
}
