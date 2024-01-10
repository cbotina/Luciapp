String? Function(String?) ageValidator = (String? value) {
  if (value == null || value == '') {
    return "Debes ingresar tu edad";
  }

  if (int.tryParse(value) == null) {
    return "Ingresa tu edad en numeros";
  }
  return null;
};
