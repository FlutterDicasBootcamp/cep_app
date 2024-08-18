import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/local/local_service/errors/local_exception.dart';
import 'package:cep_app/shared/data/local/local_service/local_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/cep_fixtures.dart';

class MockLocalService extends Mock implements LocalService {}

void main() {
  late LocalService mockLocalService;
  late GetCepDetailsByCepLocalDataSource getCepLocalDataSource;

  setUp(() {
    mockLocalService = MockLocalService();
    getCepLocalDataSource =
        GetCepDetailsByCepLocalDataSourceImpl(mockLocalService);
  });

  group('get cep local data source', () {
    test('success, right side', () async {
      when(() => mockLocalService.get<String>(any()))
          .thenAnswer((_) async => Right(tCepLocalResponse));

      final localCep = await getCepLocalDataSource.get();

      expect(localCep, isA<Right>());
    });

    test('fail, left side', () async {
      const errorMessage = 'Error get local cep';

      when(() => mockLocalService.get<String>(any())).thenAnswer(
          (_) async => Left(const LocalException(message: errorMessage)));

      final localCepEither = await getCepLocalDataSource.get();

      expect(localCepEither, isA<Left>());
      expect(((localCepEither as Left).value as CepLocalException).message,
          errorMessage);
    });
  });
}
