import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/auth_repository.dart';
import 'package:luciapp/features/auth/data/users_repository.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/main.dart';

class AuthService {
  final AuthRepository authRepository;
  final UsersRepository usersRepository;

  AuthService({
    required this.authRepository,
    required this.usersRepository,
  });

  Future<bool> isAlreadyLoggedInAndInDb() async {
    final isFederatedLoggedIn = authRepository.isAlreadyLoggedIn;
    final UserId? userId = authRepository.userId;

    if (isFederatedLoggedIn && userId != null) {
      final user = await usersRepository.findUser(userId);
      if (user != null) {
        return true;
      }
    }
    return false;
  }

  Future<AuthResult> login(AuthMethod method) async {
    late AuthResult authResult;

    switch (method) {
      case AuthMethod.facebook:
        authResult = await authRepository.loginWithFacebook();
      case AuthMethod.google:
        authResult = await authRepository.loginWithGoogle();
    }

    final UserId? userId = authRepository.userId;

    if (authResult == AuthResult.success && userId != null) {
      final user = await usersRepository.findUser(userId);

      if (user != null) {
        return authResult;
      }

      return AuthResult.registering;
    }

    return authResult;
  }

  Future<bool> register(User user) async {
    final bool savedSuccessfully = await usersRepository.saveUser(user);
    return savedSuccessfully;
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    authRepository: ref.watch(authRepositoryProvider),
    usersRepository: ref.watch(usersRepositoryProvider),
  );
});
