import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:luciapp/features/auth/data/constants/firebase_field_name.dart';
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

@immutable
class User extends MapView<String, String?> {
  final UserId userId;
  final String name;
  final Gender gender;
  final int age;

  User({
    required this.userId,
    required this.name,
    required this.gender,
    required this.age,
  }) : super({});

  User.fromJson(Map<String, dynamic> json, {required UserId userId})
      : this(
            userId: userId,
            name: json[FirebaseFieldName.username] ?? '',
            gender: json[FirebaseFieldName.gender],
            age: json[FirebaseFieldName.age]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          gender == other.gender &&
          age == other.age;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          name,
          gender,
          age,
        ],
      );
}
