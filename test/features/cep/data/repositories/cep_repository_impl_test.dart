import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:cep_app/features/cep/data/models/cep_response_model.dart';
import 'package:cep_app/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:cep_app/features/cep/domain/repositories/cep_repository.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/remote/errors/no_internet_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_fixtures.dart';

class MockGetCepDetailsByCepLocalDataSource extends Mock
    implements GetCepDetailsByCepLocalDataSource {}

class MockGetCepDetailsByCepRemoteDataSource extends Mock
    implements GetCepDetailsByCepRemoteDataSource {}

void main() {
  late GetCepDetailsByCepLocalDataSource mockGetCepDetailsByCepLocalDataSource;
  late GetCepDetailsByCepRemoteDataSource
      mockGetCepDetailsByCepRemoteDataSource;
  late CepRepository cepRepository;

  setUp(() {
    mockGetCepDetailsByCepLocalDataSource =
        MockGetCepDetailsByCepLocalDataSource();
    mockGetCepDetailsByCepRemoteDataSource =
        MockGetCepDetailsByCepRemoteDataSource();

    cepRepository = CepRepositoryImpl(mockGetCepDetailsByCepLocalDataSource,
        mockGetCepDetailsByCepRemoteDataSource);

    registerFallbackValue(tGetCepDetailsByCepBodyRight);
    registerFallbackValue(tCepObject);
  });

  group('get cep by cep', () {
    test('success', () async {
      when(() => mockGetCepDetailsByCepRemoteDataSource(any()))
          .thenAnswer((_) async => Right(tCepObject));
      when(() => mockGetCepDetailsByCepLocalDataSource.set(any()))
          .thenAnswer((_) async => Right(null));

      final cepEitherResponse =
          await cepRepository.getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepEitherResponse, isA<Right>());

      final cep = ((cepEitherResponse as Right).value) as CepResponseModel;

      expect(cep, equals(tCepObject));
    });

    test('no connection returns cached cep', () async {
      when(() => mockGetCepDetailsByCepRemoteDataSource(any()))
          .thenThrow(NoInternetException());
      when(() => mockGetCepDetailsByCepLocalDataSource.get())
          .thenAnswer((_) async => Right(tCepObject));

      final cepEitherResponse =
          await cepRepository.getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepEitherResponse, isA<Left>());

      final localCepResponse =
          ((cepEitherResponse as Left).value as CepInternetConnectionException)
              .cep;

      final newInstanceOfCepResponse = CepResponseModel(
          cep: tCepObject.cep,
          logradouro: tCepObject.logradouro,
          complemento: tCepObject.complemento,
          bairro: tCepObject.bairro,
          localidade: tCepObject.localidade,
          uf: tCepObject.uf);

      expect(localCepResponse, equals(newInstanceOfCepResponse));
    });

    test('remote and local fail', () async {
      const kErrorMessage = 'Error loading cep';

      when(() => mockGetCepDetailsByCepRemoteDataSource(any()))
          .thenThrow(NoInternetException());
      when(() => mockGetCepDetailsByCepLocalDataSource.get()).thenAnswer(
          (_) async => Left(CepLocalException(message: kErrorMessage)));

      final cepEitherResponse =
          await cepRepository.getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepEitherResponse, isA<Left>());

      final errorMessage =
          ((cepEitherResponse as Left).value as CepLocalException).message;

      expect(errorMessage, equals(kErrorMessage));
    });
  });
}
