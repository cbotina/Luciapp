import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/presentation/controllers/auth_controller.dart';
import 'package:luciapp/features/auth/presentation/state/auth_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService authService;

  setUp(() {
    authService = MockAuthService();
  });
  group('AuthController', () {
    group('Login', () {
      test("Successfull Google login", () async {
        when(() => authService.login(AuthMethod.google))
            .thenAnswer((_) => Future.value(AuthResult.success));

        when(authService.getUserId).thenAnswer((_) => '1234');

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithGoogle();

        verify(() => authService.login(AuthMethod.google)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.success,
            isLoading: false,
            userId: '1234',
          ),
        );
      });
      test("Successfull Facebook login", () async {
        when(() => authService.login(AuthMethod.facebook))
            .thenAnswer((_) => Future.value(AuthResult.success));

        when(authService.getUserId).thenAnswer((_) => '1234');

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithFacebook();

        verify(() => authService.login(AuthMethod.facebook)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.success,
            isLoading: false,
            userId: '1234',
          ),
        );
      });

      test("Failed Google login", () async {
        when(() => authService.login(AuthMethod.google))
            .thenAnswer((_) => Future.value(AuthResult.failure));

        when(authService.getUserId).thenAnswer((_) => null);

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithGoogle();

        verify(() => authService.login(AuthMethod.google)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.failure,
            isLoading: false,
            userId: null,
          ),
        );
      });

      test("Failed Facebook login", () async {
        when(() => authService.login(AuthMethod.facebook))
            .thenAnswer((_) => Future.value(AuthResult.failure));

        when(authService.getUserId).thenAnswer((_) => null);

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithFacebook();

        verify(() => authService.login(AuthMethod.facebook)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.failure,
            isLoading: false,
            userId: null,
          ),
        );
      });

      test("Aborted Google login", () async {
        when(() => authService.login(AuthMethod.google))
            .thenAnswer((_) => Future.value(AuthResult.aborted));

        when(authService.getUserId).thenAnswer((_) => null);

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithGoogle();

        verify(() => authService.login(AuthMethod.google)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.aborted,
            isLoading: false,
            userId: null,
          ),
        );
      });

      test("Aborted Facebook login", () async {
        when(() => authService.login(AuthMethod.facebook))
            .thenAnswer((_) => Future.value(AuthResult.aborted));

        when(authService.getUserId).thenAnswer((_) => null);

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithFacebook();

        verify(() => authService.login(AuthMethod.facebook)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.aborted,
            isLoading: false,
            userId: null,
          ),
        );
      });

      test("Redirect to Register from Google", () async {
        when(() => authService.login(AuthMethod.google))
            .thenAnswer((_) => Future.value(AuthResult.registering));

        when(authService.getUserId).thenAnswer((_) => '1234');

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithGoogle();

        verify(() => authService.login(AuthMethod.google)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.registering,
            isLoading: false,
            userId: '1234',
          ),
        );
      });

      test("Redirect to Register from Facebook", () async {
        when(() => authService.login(AuthMethod.facebook))
            .thenAnswer((_) => Future.value(AuthResult.registering));

        when(authService.getUserId).thenAnswer((_) => '1234');

        final controller = AuthController(authService: authService);

        expect(controller.state, const AuthState.unknown());

        await controller.loginWithFacebook();

        verify(() => authService.login(AuthMethod.facebook)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.registering,
            isLoading: false,
            userId: '1234',
          ),
        );
      });
    });

    group("Logout", () {
      test("Sucessfull logout", () async {
        when(authService.logOut).thenAnswer((_) => Future.value());
        final controller = AuthController(authService: authService);
        await controller.logOut();
        expect(controller.state, const AuthState.unknown());
      });
    });

    group("Register", () {
      test("Successfull register", () async {
        final User user = User(
          userId: '1234',
          age: 21,
          gender: Gender.female,
          name: "Alice",
        );

        when(() => authService.register(user))
            .thenAnswer((_) => Future.value(true));

        when(authService.getUserId).thenAnswer((_) => '1234');

        final controller = AuthController(authService: authService);

        await controller.register(user);

        verify(() => authService.register(user)).called(1);

        expect(
          controller.state,
          const AuthState(
            result: AuthResult.success,
            isLoading: false,
            userId: '1234',
          ),
        );
      });

      test("Failed register", () async {
        final User user = User(
          userId: '1234',
          age: 21,
          gender: Gender.female,
          name: "Alice",
        );

        when(() => authService.register(user))
            .thenAnswer((_) => Future.value(false));

        when(authService.getUserId).thenAnswer((_) => null);

        final controller = AuthController(authService: authService);

        await controller.register(user);

        verify(() => authService.register(user)).called(1);

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
  });
}
