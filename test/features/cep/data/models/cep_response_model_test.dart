import 'package:cep_app/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/cep_fixtures.dart';

void main() {
  test('should convert CepResponseModel into JSON', () {
    final cepJson = tCepObject.toJSON();

    expect(cepJson, equals(tCepLocalResponse));
  });

  test('should convert Map to CepResponseModel', () {
    final cepResponse = CepResponseModel.fromMap(tCepApiResponse);

    expect(cepResponse, equals(tCepObject));
  });

  test('should convert JSON to CepResponseModel', () {
    final cepResponse = CepResponseModel.fromJson(tCepLocalResponse);

    expect(cepResponse, equals(tCepObject));
  });
}
