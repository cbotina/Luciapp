import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';

String? Function(String?) ageValidator = (String? value) {
  if (value == null || value == '') {
    return Strings.ageIsRequired;
  }

  if (int.tryParse(value) == null) {
    return Strings.ageMustBeANumber;
  }
  return null;
};
