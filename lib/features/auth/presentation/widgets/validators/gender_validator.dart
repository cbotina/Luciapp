import 'package:luciapp/features/auth/domain/enums/gender.dart';

String? Function(Gender?) genderValidator = (Gender? selectedGender) {
  if (selectedGender == null) return "Debes seleccionar un genero";
  return null;
};
