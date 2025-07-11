import 'package:cep_app/features/cep/presentation/const/validation_messages_const.dart';
import 'package:cep_app/features/cep/presentation/widgets/app_bar/cep_screen_app_bar_widget.dart';
import 'package:cep_app/features/cep/presentation/widgets/tabs/search_by_local_details_tab_widget.dart';
import 'package:cep_app/shared/main/cep_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search by local details tab widget', () {
    testWidgets('should find insert local label', (tester) async {
      await tester.pumpWidget(const CepApp());

      final localDetailsTabButton = find.byKey(localDetailsKey);

      await tester.tap(localDetailsTabButton);

      await tester.pumpAndSettle();

      final insertAZipCode = find.text('Insira um Local:');

      expect(insertAZipCode, findsOneWidget);
    });

    testWidgets('should show required local details form validation errors',
        (tester) async {
      await tester.pumpWidget(const CepApp());

      final localDetailsTabButton = find.byKey(localDetailsKey);

      await tester.ensureVisible(localDetailsTabButton);

      await tester.pumpAndSettle();

      await tester.tap(localDetailsTabButton);

      await tester.pumpAndSettle();

      final button = find.byKey(searchZipCodeByLocalDetailsButtonKey);

      await tester.tap(button);

      await tester.pumpAndSettle();

      final errorStateValidationText =
          find.text(ValidationMessagesConst.notEmpty('Estado'));

      expect(errorStateValidationText, findsOneWidget);

      final errorCityValidationText =
          find.text(ValidationMessagesConst.notEmpty('Cidade'));

      expect(errorCityValidationText, findsOneWidget);

      final errorStreetValidationText =
          find.text(ValidationMessagesConst.notEmpty('Rua'));

      expect(errorStreetValidationText, findsOneWidget);
    });
  });
}
