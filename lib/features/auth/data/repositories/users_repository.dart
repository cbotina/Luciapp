import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

abstract class UsersRepository {
  Future<User> findUser(UserId userId);
  Future<bool> saveUser(User user);
}
