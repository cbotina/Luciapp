import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/auth/data/constants/firebase_collection_name.dart';
import 'package:luciapp/features/auth/data/constants/firebase_field_name.dart';
import 'package:luciapp/features/auth/domain/models/user.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

final userInfoModelProvider = StreamProvider.family.autoDispose<User, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<User>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      final doc = snapshot.docs.first;
      print(doc);
      final json = doc.data();

      final userInfoModel = User.fromJson(json, userId: userId);
      controller.add(userInfoModel);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
