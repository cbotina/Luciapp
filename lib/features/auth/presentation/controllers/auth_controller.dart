import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/application/auth_service.dart';
import 'package:luciapp/features/auth/domain/enums/auth_method.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/presentation/state/auth_state.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthController({required this.authService})
      : super(const AuthState.unknown());

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await authService.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);

    final AuthResult result = await authService.login(AuthMethod.google);
    final UserId? userId = authService.getUserId();

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithIsLoading(true);

    final AuthResult result = await authService.login(AuthMethod.facebook);
    final UserId? userId = authService.getUserId();

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> register(User user) async {
    state = state.copyWithIsLoading(true);
    final bool success = await authService.register(user);
    final UserId? userId = authService.getUserId();

    state = AuthState(
      result: success ? AuthResult.success : AuthResult.failure,
      isLoading: false,
      userId: userId,
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(authService: ref.watch(authServiceProvider));
});
