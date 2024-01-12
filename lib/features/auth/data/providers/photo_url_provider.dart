import 'dart:async';
import 'package:luciapp/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

final fetchPhotoUrlProvider =
    StreamProvider.family.autoDispose<String?, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<String?>();

    final stream = ref.watch(authRepositoryProvider).authStateChanges;

    final sub = stream.listen((user) {
      final photoURL = user?.photoURL;
      controller.add(photoURL);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
