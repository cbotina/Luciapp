import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/datasources/authenticator.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';
import 'package:luciapp/features/auth/domain/models/auth_state.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);

    final AuthResult result = await _authenticator.loginWithGoogle();
    final UserId? userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      //await saveUserInfo(userId: userId);
      // check in database
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  // Future<void> loginWithFacebook() async {
  //   state = state.copyWithIsLoading(true);

  //   final AuthResult result = await _authenticator.loginWithFacebook();
  //   final UserId? userId = _authenticator.userId;

  //   if (result == AuthResult.success && userId != null) {
  //     await saveUserInfo(userId: userId);
  //   }

  //   state = AuthState(
  //     result: result,
  //     isLoading: false,
  //     userId: userId,
  //   );
  // }

  // Future<void> saveUserInfo({required UserId userId}) {
  //   return _userInfoStorage.saveUserInfo(
  //     userId: userId,
  //     displayName: _authenticator.displayName,
  //     email: _authenticator.email,
  //   );
  // }
}
