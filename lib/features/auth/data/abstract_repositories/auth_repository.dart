import 'package:firebase_auth/firebase_auth.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';

abstract class AuthRepository {
  UserId? get userId;
  String get displayName;
  Stream<User?> get authStateChanges;

  Future<void> logOut();
  Future<AuthResult> loginWithFacebook();
  Future<AuthResult> loginWithGoogle();
}
