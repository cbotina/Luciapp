import 'package:flutter_test/flutter_test.dart';
import 'package:luciapp/main.dart';

void main() {
  // ... Otros tests ...

  testWidgets('[CP-XXX] Prueba de integracion', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(const MyApp());

    // ... Contenido del test ...

    // ? Verifica un area activa de 48x48 px
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // ? Verifica un area activa de 44x44 px
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    handle.dispose();
  });
}
