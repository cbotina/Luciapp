import 'package:luciapp/features/auth/presentation/widgets/constants/strings.dart';

String? Function(String?) nameValidator = (String? value) {
  if (value == null || value == '') {
    return Strings.nameIsRequired;
  }
  return null;
};
