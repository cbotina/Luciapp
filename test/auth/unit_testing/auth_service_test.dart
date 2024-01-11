import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:mocktail/mocktail.dart';
import '../../../integration_test/foo_test.dart';
import '../mocks/mock_users_repository.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockUsersRepository usersRepository;
  late User existingUser;

  setUp(() {
    authRepository = MockAuthRepository();
    usersRepository = MockUsersRepository();
    existingUser = User(
      userId: '1234',
      name: 'Bob',
      age: 21,
      gender: Gender.male,
    );
  });

  group("(AuthService)", () {
    test("[CP-011] Sucessfull Google login of new user", () async {
      when(authRepository.loginWithGoogle).thenAnswer(
        (invocation) => Future.value(AuthResult.success),
      );

      when(() => authRepository.userId).thenAnswer((_) => '1234');

      when(() => usersRepository.findUser('1234'))
          .thenAnswer((_) => Future.value(null));

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.google);

      expect(result, AuthResult.registering);
    });

    test("[CP-012] Sucessfull Facebook login of new user", () async {
      when(authRepository.loginWithFacebook).thenAnswer(
        (invocation) => Future.value(AuthResult.success),
      );

      when(() => authRepository.userId).thenAnswer((_) => '1234');

      when(() => usersRepository.findUser('1234'))
          .thenAnswer((_) => Future.value(null));

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.facebook);

      expect(result, AuthResult.registering);
    });

    test("[CP-013] Sucessfull Google login of existing user", () async {
      when(authRepository.loginWithGoogle).thenAnswer(
        (invocation) => Future.value(AuthResult.success),
      );

      when(() => authRepository.userId).thenAnswer((_) => '1234');

      when(() => usersRepository.findUser('1234'))
          .thenAnswer((_) => Future.value(existingUser));

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.google);

      expect(result, AuthResult.success);
    });

    test("[CP-014] Sucessfull Facebook login of existing user", () async {
      when(authRepository.loginWithFacebook).thenAnswer(
        (invocation) => Future.value(AuthResult.success),
      );

      when(() => authRepository.userId).thenAnswer((_) => '1234');

      when(() => usersRepository.findUser('1234'))
          .thenAnswer((_) => Future.value(existingUser));

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.facebook);

      expect(result, AuthResult.success);
    });

    test("[CP-015] Failed Google login", () async {
      when(authRepository.loginWithGoogle).thenAnswer(
        (invocation) => Future.value(AuthResult.failure),
      );

      when(() => authRepository.userId).thenAnswer((_) => null);

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.google);

      expect(result, AuthResult.failure);
    });

    test("[CP-016] Failed Facebook login", () async {
      when(authRepository.loginWithFacebook).thenAnswer(
        (invocation) => Future.value(AuthResult.failure),
      );

      when(() => authRepository.userId).thenAnswer((_) => null);

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.facebook);

      expect(result, AuthResult.failure);
    });

    test("[CP-017] Aborted Google login", () async {
      when(authRepository.loginWithGoogle).thenAnswer(
        (invocation) => Future.value(AuthResult.aborted),
      );

      when(() => authRepository.userId).thenAnswer((_) => null);

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.google);

      expect(result, AuthResult.aborted);
    });

    test("[CP-018] Aborted Facebook login", () async {
      when(authRepository.loginWithFacebook).thenAnswer(
        (invocation) => Future.value(AuthResult.aborted),
      );

      when(() => authRepository.userId).thenAnswer((_) => null);

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = await service.login(AuthMethod.facebook);

      expect(result, AuthResult.aborted);
    });
  });

  test("[CP-019] Successfull register", () async {
    final newUser = User(
      userId: "5678",
      name: "Alice",
      age: 21,
      gender: Gender.male,
    );
    when(() => usersRepository.saveUser(newUser)).thenAnswer(
      (_) => Future.value(true),
    );

    final service = AuthService(
      authRepository: authRepository,
      usersRepository: usersRepository,
    );

    final result = await service.register(newUser);

    expect(result, true);
  });

  test("[CP-020] Failed register", () async {
    final newUser = User(
      userId: "5678",
      name: "Alice",
      age: 21,
      gender: Gender.male,
    );
    when(() => usersRepository.saveUser(newUser)).thenAnswer(
      (_) => Future.value(false),
    );

    final service = AuthService(
      authRepository: authRepository,
      usersRepository: usersRepository,
    );

    final result = await service.register(newUser);

    expect(result, false);
  });

  test("[CP-021] Get existing userId", () {
    when(() => authRepository.userId).thenAnswer((_) => '1234');
    final service = AuthService(
      authRepository: authRepository,
      usersRepository: usersRepository,
    );

    final result = service.getUserId();

    expect(result, '1234');
  });

  test("[CP-022] Get null userId", () {
    when(() => authRepository.userId).thenAnswer((_) => null);

    final service = AuthService(
      authRepository: authRepository,
      usersRepository: usersRepository,
    );

    final result = service.getUserId();

    expect(result, null);
  });

  test("[CP-023] Logout", () async {
    when(authRepository.logOut).thenAnswer((_) => Future.value());

    final service = AuthService(
      authRepository: authRepository,
      usersRepository: usersRepository,
    );

    await service.logOut();

    verify(authRepository.logOut).called(1);
  });
}
