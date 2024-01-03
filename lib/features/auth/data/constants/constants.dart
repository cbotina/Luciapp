import 'package:flutter/foundation.dart';

@immutable
class Constants {
  // FirebaseAuthException error-code
  static const accountExistsWithDifferentCredential =
      'account-exists-with-differente-credential';

  // For Google Login
  static const googleCom = 'google.com';
  static const emailScope = 'email';

  // Private constructor
  const Constants._();
}
