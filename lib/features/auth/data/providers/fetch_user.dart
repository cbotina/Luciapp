import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:luciapp/main.dart';

final fetchUserProvider =
    FutureProvider.autoDispose.family<User?, UserId>((ref, userId) async {
  return ref.watch(usersRepositoryProvider).findUser(userId);
});
