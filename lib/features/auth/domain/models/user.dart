import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/common/constants/firebase_field_name.dart';
import 'package:luciapp/features/auth/domain/typedefs/user_id.dart';

@immutable
class User extends MapView<String, dynamic> {
  final UserId _userId;
  final String _name;
  final Gender _gender;
  final int _age;

  User({
    required userId,
    required name,
    required gender,
    required age,
  })  : _age = age,
        _gender = gender,
        _name = name,
        _userId = userId,
        super(
          {
            FirebaseFieldName.username: name,
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.age: age,
            FirebaseFieldName.gender: gender.toString(),
          },
        );

  User.fromJson(Map<String, dynamic> json, {required UserId userId})
      : this(
          userId: userId,
          name: json[FirebaseFieldName.username] ?? '',
          gender: json[FirebaseFieldName.gender].toString().toGender(),
          age: json[FirebaseFieldName.age] ?? 0,
        );

  UserId get userId => _userId;
  String get name => _name;
  Gender get gender => _gender;
  int get age => _age;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          _userId == other.userId &&
          _name == other.name &&
          _gender == other.gender &&
          _age == other.age;

  @override
  int get hashCode => Object.hashAll(
        [
          _userId,
          _name,
          _gender,
          _age,
        ],
      );
}
