import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:cep_app/shared/const/const_strings.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/models/api_response_model.dart';
import 'package:cep_app/shared/data/remote/api_service.dart';
import 'package:cep_app/shared/data/remote/errors/api_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/cep_fixtures.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late ApiService mockApiService;
  late GetCepDetailsByCepRemoteDataSource cepRemoteDataSource;

  setUp(() {
    mockApiService = MockApiService();
    cepRemoteDataSource =
        GetCepDetailsByCepRemoteDataSourceImpl(mockApiService);
  });

  group('get cep remote data source', () {
    test('success', () async {
      when(() => mockApiService.get(any())).thenAnswer(
        (_) async => Right(
          const ApiResponseModel(
            data: tCepApiResponse,
            statusCode: 200,
          ),
        ),
      );

      final remoteCepResponse =
          await cepRemoteDataSource(tGetCepDetailsByCepBodyRight);

      expect(remoteCepResponse, isA<Right>());
      expect((remoteCepResponse as Right).value, tCepObject);
    });

    test('fail', () async {
      when(() => mockApiService.get(any())).thenAnswer(
        (_) async => Left(
          ApiException(
            identifier: 'identifier',
            statusCode: 500,
            errorStatus: ErrorStatus.internalServerError,
            message: ConstStrings.kDefaultErrorMessage,
          ),
        ),
      );

      final remoteCepResponse =
          await cepRemoteDataSource(tGetCepDetailsByCepBodyLeft);

      expect(remoteCepResponse, isA<Left>());
      expect(((remoteCepResponse as Left).value as CepRemoteException).message,
          ConstStrings.kDefaultErrorMessage);
    });
  });
}
