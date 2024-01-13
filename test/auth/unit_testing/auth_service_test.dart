import '../constants/strings.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mock_auth_repository.dart';
import '../mocks/mock_users_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';

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

  group(TestNames.unitTest, () {
    test(TestNames.cp012, () async {
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

    test(TestNames.cp013, () async {
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

    test(TestNames.cp014, () async {
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

    test(TestNames.cp015, () async {
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

    test(TestNames.cp016, () async {
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

    test(TestNames.cp017, () async {
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

    test(TestNames.cp018, () async {
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

    test(TestNames.cp019, () async {
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

    test(TestNames.cp020, () async {
      when(authRepository.logOut).thenAnswer((_) => Future.value());

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      await service.logOut();

      verify(authRepository.logOut).called(1);
    });

    test(TestNames.cp021, () async {
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

    test(TestNames.cp022, () async {
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

    test(TestNames.cp023, () {
      when(() => authRepository.userId).thenAnswer((_) => '1234');
      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = service.getUserId();

      expect(result, '1234');
    });

    test(TestNames.cp024, () {
      when(() => authRepository.userId).thenAnswer((_) => null);

      final service = AuthService(
        authRepository: authRepository,
        usersRepository: usersRepository,
      );

      final result = service.getUserId();

      expect(result, null);
    });
  });
}
