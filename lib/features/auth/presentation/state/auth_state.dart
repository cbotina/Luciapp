import 'package:flutter/foundation.dart' show immutable;
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';

@immutable
class AuthState {
  final AuthResult result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = AuthResult.none,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoading) => AuthState(
        isLoading: isLoading,
        result: result,
        userId: userId,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
