import 'package:cep_app/features/cep/presentation/const/validation_messages_const.dart';
import 'package:cep_app/features/cep/presentation/widgets/tabs/search_by_cep_tab_widget.dart';
import 'package:cep_app/shared/main/cep_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cep Screen', () {
    testWidgets('should find AppBar title', (tester) async {
      await tester.pumpWidget(const CepApp());

      final title = find.text('Cep App - Clean Architecture');

      expect(title, findsOneWidget);
    });

    testWidgets('should find insert zip code label', (tester) async {
      await tester.pumpWidget(const CepApp());

      final insertAZipCode = find.text('Insira um CEP');

      expect(insertAZipCode, findsOneWidget);
    });

    testWidgets('should show required zip code validation error',
        (tester) async {
      await tester.pumpWidget(const CepApp());

      final searchByZipCodeButton = find.byKey(searchByZipCodeButtonKey);

      await tester.tap(searchByZipCodeButton);

      await tester.pumpAndSettle();

      final errorValidationText =
          find.text(ValidationMessagesConst.notEmpty('CEP'));

      expect(errorValidationText, findsOneWidget);
    });
  });
}
