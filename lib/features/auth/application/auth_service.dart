import 'package:luciapp/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/auth_repository.dart';
import 'package:luciapp/features/auth/data/abstract_repositories/users_repository.dart';

class AuthService {
  final IAuthRepository _authRepository;
  final IUsersRepository _usersRepository;

  AuthService({
    required IAuthRepository authRepository,
    required IUsersRepository usersRepository,
  })  : _usersRepository = usersRepository,
        _authRepository = authRepository;

  Future<AuthResult> login(AuthMethod method) async {
    late AuthResult authResult;

    switch (method) {
      case AuthMethod.facebook:
        authResult = await _authRepository.loginWithFacebook();
      case AuthMethod.google:
        authResult = await _authRepository.loginWithGoogle();
    }

    final UserId? userId = _authRepository.userId;

    if (authResult == AuthResult.success && userId != null) {
      final user = await _usersRepository.findUser(userId);

      if (user != null) {
        return authResult;
      }

      return AuthResult.registering;
    }

    return authResult;
  }

  Future<bool> register(User user) async {
    final bool savedSuccessfully = await _usersRepository.saveUser(user);
    return savedSuccessfully;
  }

  UserId? getUserId() {
    return _authRepository.userId;
  }

  Future<void> logout() async {
    return await _authRepository.logout();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    authRepository: ref.watch(authRepositoryProvider),
    usersRepository: ref.watch(usersRepositoryProvider),
  );
});
