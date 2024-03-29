import 'package:flutter/foundation.dart' show immutable;

@immutable
class Siu {
// Unit Tests
  static const String unitTest = "Unit Test";

  static const String cp064 = "[CP-064] Set course colors for light theme";
  static const String cp065 = "[CP-065] Set course colors for dark theme";
  static const String cp066 =
      "[CP-066] Set course colors for high contrast light theme";
  static const String cp067 =
      "[CP-067] Set course colors for high contrast dark theme";

// Integration Tests
  static const String integrationTest = "Integration Test";

  static const String cp068 =
      "[CP-068] Display list of courses when records exist in the database";
  static const String cp069 =
      "[CP-069] Get message when there are no courses in the database";
  static const String cp070 =
      "[CP-070] Show notice when there is no internet connection";
}

@immutable
class TestNames {
// Pruebas Unitarias
  static const String unitTest = "Prueba Unitaria";

  static const String cp064 =
      "[CP-064] Establecer colores del curso para el tema claro";
  static const String cp065 =
      "[CP-065] Establecer colores del curso para el tema oscuro";
  static const String cp066 =
      "[CP-066] Establecer colores del curso para el tema de alto contraste claro";
  static const String cp067 =
      "[CP-067] Establecer colores del curso para el tema de alto contraste oscuro";

// Pruebas de Integración
  static const String integrationTest = "Prueba de Integración";

  static const String cp068 =
      "[CP-068] Mostrar lista de cursos cuando existen registros en la base de datos";
  static const String cp069 =
      "[CP-069] Obtener mensaje cuando no existen cursos en la base de datos";
  static const String cp070 =
      "[CP-070] Mostrar aviso cuando no se cuenta con una conexión a internet";
}
