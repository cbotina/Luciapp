import '../constants/strings.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mock_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/presentation/state/auth_state.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });
  group(TestNames.unitTest, () {
    test(TestNames.cp001, () async {
      when(() => mockAuthService.login(AuthMethod.google))
          .thenAnswer((_) => Future.value(AuthResult.success));

      when(mockAuthService.getUserId).thenAnswer((_) => '1234');

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithGoogle();

      verify(() => mockAuthService.login(AuthMethod.google)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: '1234',
        ),
      );
    });

    test(TestNames.cp002, () async {
      when(() => mockAuthService.login(AuthMethod.google))
          .thenAnswer((_) => Future.value(AuthResult.failure));

      when(mockAuthService.getUserId).thenAnswer((_) => null);

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithGoogle();

      verify(() => mockAuthService.login(AuthMethod.google)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.failure,
          isLoading: false,
          userId: null,
        ),
      );
    });

    test(TestNames.cp003, () async {
      when(() => mockAuthService.login(AuthMethod.google))
          .thenAnswer((_) => Future.value(AuthResult.aborted));

      when(mockAuthService.getUserId).thenAnswer((_) => null);

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithGoogle();

      verify(() => mockAuthService.login(AuthMethod.google)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.aborted,
          isLoading: false,
          userId: null,
        ),
      );
    });

    test(TestNames.cp004, () async {
      when(() => mockAuthService.login(AuthMethod.google))
          .thenAnswer((_) => Future.value(AuthResult.registering));

      when(mockAuthService.getUserId).thenAnswer((_) => '1234');

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithGoogle();

      verify(() => mockAuthService.login(AuthMethod.google)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.registering,
          isLoading: false,
          userId: '1234',
        ),
      );
    });

    test(TestNames.cp005, () async {
      when(() => mockAuthService.login(AuthMethod.facebook))
          .thenAnswer((_) => Future.value(AuthResult.success));

      when(mockAuthService.getUserId).thenAnswer((_) => '1234');

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithFacebook();

      verify(() => mockAuthService.login(AuthMethod.facebook)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: '1234',
        ),
      );
    });

    test(TestNames.cp006, () async {
      when(() => mockAuthService.login(AuthMethod.facebook))
          .thenAnswer((_) => Future.value(AuthResult.failure));

      when(mockAuthService.getUserId).thenAnswer((_) => null);

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithFacebook();

      verify(() => mockAuthService.login(AuthMethod.facebook)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.failure,
          isLoading: false,
          userId: null,
        ),
      );
    });

    test(TestNames.cp007, () async {
      when(() => mockAuthService.login(AuthMethod.facebook))
          .thenAnswer((_) => Future.value(AuthResult.aborted));

      when(mockAuthService.getUserId).thenAnswer((_) => null);

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithFacebook();

      verify(() => mockAuthService.login(AuthMethod.facebook)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.aborted,
          isLoading: false,
          userId: null,
        ),
      );
    });

    test(TestNames.cp008, () async {
      when(() => mockAuthService.login(AuthMethod.facebook))
          .thenAnswer((_) => Future.value(AuthResult.registering));

      when(mockAuthService.getUserId).thenAnswer((_) => '1234');

      final controller = AuthController(authService: mockAuthService);

      expect(controller.state, const AuthState.unknown());

      await controller.loginWithFacebook();

      verify(() => mockAuthService.login(AuthMethod.facebook)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.registering,
          isLoading: false,
          userId: '1234',
        ),
      );
    });

    test(TestNames.cp009, () async {
      when(mockAuthService.logout).thenAnswer((_) => Future.value());
      final controller = AuthController(authService: mockAuthService);
      await controller.logout();
      expect(controller.state, const AuthState.unknown());
    });

    test(TestNames.cp010, () async {
      final User user = User(
        userId: '1234',
        age: 21,
        gender: Gender.female,
        name: "Alice",
      );

      when(() => mockAuthService.register(user))
          .thenAnswer((_) => Future.value(true));

      when(mockAuthService.getUserId).thenAnswer((_) => '1234');

      final controller = AuthController(authService: mockAuthService);

      await controller.register(user);

      verify(() => mockAuthService.register(user)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: '1234',
        ),
      );
    });

    test(TestNames.cp011, () async {
      final User user = User(
        userId: '1234',
        age: 21,
        gender: Gender.female,
        name: "Alice",
      );

      when(() => mockAuthService.register(user))
          .thenAnswer((_) => Future.value(false));

      when(mockAuthService.getUserId).thenAnswer((_) => null);

      final controller = AuthController(authService: mockAuthService);

      await controller.register(user);

      verify(() => mockAuthService.register(user)).called(1);

      expect(
        controller.state,
        const AuthState(
          result: AuthResult.failure,
          isLoading: false,
          userId: null,
        ),
      );
    });
  });
}
