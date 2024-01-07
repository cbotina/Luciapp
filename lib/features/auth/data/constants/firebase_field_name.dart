import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'id';
  static const username = 'name';
  static const gender = 'gender';
  static const age = 'age';

  const FirebaseFieldName._();
}
