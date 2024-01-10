String? Function(String?) nameValidator = (String? value) {
  if (value == null || value == '') {
    return "Debes ingresar tu nombre";
  }
  return null;
};
