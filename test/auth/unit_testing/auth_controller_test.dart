import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/state/auth_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mocks/mock_auth_service.dart';

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });
  group('(AuthController)', () {
    test("[CP-001] Successfull Google login", () async {
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

    test("[CP-002] Failed Google login", () async {
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

    test("[CP-003] Aborted Google login", () async {
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

    test("[CP-004] Redirect to Register from Google", () async {
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
    test("[CP-005] Successfull Facebook login", () async {
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

    test("[CP-006] Failed Facebook login", () async {
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

    test("[CP-007] Aborted Facebook login", () async {
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

    test("[CP-008] Redirect to Register from Facebook", () async {
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

    test("[CP-009] Sucessfull logout", () async {
      when(mockAuthService.logOut).thenAnswer((_) => Future.value());
      final controller = AuthController(authService: mockAuthService);
      await controller.logOut();
      expect(controller.state, const AuthState.unknown());
    });

    test("[CP-010] Successfull register", () async {
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

    test("[CP-011] Failed register", () async {
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
