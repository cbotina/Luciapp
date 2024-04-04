import 'package:luciapp/features/auth/domain/enums/gender.dart';
import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';

String? Function(Gender?) genderValidator = (Gender? selectedGender) {
  if (selectedGender == null) return Strings.genderIsRequired;
  return null;
};
