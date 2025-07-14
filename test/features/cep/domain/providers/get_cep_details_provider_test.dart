import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_local_details_local_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_local_details_remote_data_source.dart';
import 'package:cep_app/features/cep/domain/providers/get_cep_details_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final providerContainer = ProviderContainer();
  late GetCepDetailsByLocalDetailsRemoteDataSource getCepRemoteDataSource;
  late GetCepDetailsByLocalDetailsLocalDataSource getCepLocalDataSource;

  setUp(() {
    getCepRemoteDataSource =
        providerContainer.read<GetCepDetailsByLocalDetailsRemoteDataSource>(
            getCepDetailsByLocalDetailsRemoteDataSource);
    getCepLocalDataSource =
        providerContainer.read<GetCepDetailsByLocalDetailsLocalDataSource>(
            getCepDetailsByLocalDetailsLocalDataSource);
  });

  test(
      'getCepRemoteDataSource is a GetCepDetailsByLocalDetailsRemoteDataSource',
      () {
    expect(getCepRemoteDataSource,
        isA<GetCepDetailsByLocalDetailsRemoteDataSource>());
  });

  test('getCepLocalDataSource is a GetCepDetailsByLocalDetailsLocalDataSource',
      () {
    expect(getCepLocalDataSource,
        isA<GetCepDetailsByLocalDetailsLocalDataSource>());
  });
}
