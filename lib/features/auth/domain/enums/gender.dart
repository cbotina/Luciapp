import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart';

enum Gender {
  male(name: 'Masculino'),
  female(name: 'Femenino'),
  nonBinary(name: 'No binario');

  final String name;

  const Gender({
    required this.name,
  });

  @override
  GenderString toString() {
    return name;
  }
}

typedef GenderString = String;

extension ToIcon on GenderString {
  Widget? toIcon() {
    switch (this) {
      case "Masculino":
        return const Male();
      case "Femenino":
        return const Female();
      case "No binario":
        return const NonBinary();
      default:
        return null;
    }
  }
}

extension ToGender on GenderString {
  Gender toGender() {
    switch (this) {
      case "Gender.male":
        return Gender.male;
      case "Gender.female":
        return Gender.female;
      case "Gender.nonBinary":
        return Gender.nonBinary;
      default:
        return Gender.male;
    }
  }
}
