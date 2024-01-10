import 'dart:async';

import 'package:luciapp/features/auth/data/constants/firebase_collection_name.dart';
import 'package:luciapp/features/auth/data/constants/firebase_field_name.dart';
import 'package:luciapp/features/auth/data/users_repository.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepository implements UsersRepository {
  const FirebaseUserRepository();

  @override
  Future<User?> findUser(UserId userId) async {
    final user = await FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.users,
        )
        .where(
          FirebaseFieldName.userId,
          isEqualTo: userId,
        )
        .limit(1)
        .get();

    if (user.docs.isNotEmpty) {
      return User.fromJson(user.docs.first.data(), userId: userId);
    } else {
      return null;
    }
  }

  @override
  Future<bool> saveUser(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
