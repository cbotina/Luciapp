import 'package:luciapp/features/auth/data/repositories/users_repository.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

class FirebaseUserRepository implements UsersRepository {
  @override
  Future<User> findUser(UserId userId) {
    // TODO: implement findUser
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }
}
