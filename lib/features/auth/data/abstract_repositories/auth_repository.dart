import 'package:firebase_auth/firebase_auth.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';

abstract class IAuthRepository {
  UserId? get userId;
  String get displayName;
  Stream<User?> get authStateChanges;

  Future<void> logout();
  Future<AuthResult> loginWithFacebook();
  Future<AuthResult> loginWithGoogle();
}
