import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

final photoUrlProvider = StreamProvider.family.autoDispose<String, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<String>();
    final sub = FirebaseAuth.instance.authStateChanges().listen((user) {
      final photoURL = user?.photoURL;
      controller.add(photoURL ?? "");
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
