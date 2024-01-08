import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luciapp/features/auth/data/constants/constants.dart';
import 'package:luciapp/features/auth/domain/enums/auth_result.dart';

import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

class AuthRepository {
  const AuthRepository();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String? get photoUrl => FirebaseAuth.instance.currentUser?.photoURL;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    //await PhoneAuth.instance.logOut();
  }

  Future<AuthResult> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final String? token = loginResult.accessToken?.token;

    if (token == null) {
      // user has aborted
      return AuthResult.aborted;
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final String? email = e.email;
      final AuthCredential? credential = e.credential;

      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(
          email,
        );
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          // ! ojito
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }

        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.emailScope],
    );

    final signInAccount = await googleSignIn.signIn();

    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;

    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
