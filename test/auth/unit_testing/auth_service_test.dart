import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/data/firebase_auth_repository.dart';
import 'package:luciapp/features/auth/data/users_repository.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FirebaseAuthRepository {}

class MockUsersRepository extends Mock implements UsersRepository {}

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

  group("Login", () {
    test("Sucessfull Google login of new user", () async {
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

    test("Sucessfull Facebook login of new user", () async {
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

    test("Sucessfull Google login of existing user", () async {
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

    test("Sucessfull Facebook login of existing user", () async {
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

    test("Failed Google login", () async {
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

    test("Failed Facebook login", () async {
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

    test("Aborted Google login", () async {
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

    test("Aborted Google login", () async {
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
  });

  group("Register", () {
    test("Successfull register", () async {
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

    test("Failed register", () async {
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
  });
  group("Get userId", () {
    test("Get existing userId", () {
      when(() => authRepository.userId).thenAnswer((_) => '1234');
      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = service.getUserId();

      expect(result, '1234');
    });

    test("Get null userId", () {
      when(() => authRepository.userId).thenAnswer((_) => null);

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = service.getUserId();

      expect(result, null);
    });
  });
  group("Logout", () {
    test("Logout", () async {
      when(authRepository.logOut).thenAnswer((_) => Future.value());

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      await service.logOut();

      verify(authRepository.logOut).called(1);
    });
  });
}
