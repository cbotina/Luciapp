import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  // FirebaseAuthException error-code
  static const accountExistsWithDifferentCredential =
      'account-exists-with-differente-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';

  const Constants._();
}
