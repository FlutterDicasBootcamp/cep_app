import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_local_details_local_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_local_details_remote_data_source.dart';
import 'package:cep_app/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:cep_app/features/cep/domain/repositories/cep_repository.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:cep_app/shared/data/local/local_service/local_service.dart';
import 'package:cep_app/shared/data/remote/api_service.dart';
import 'package:cep_app/shared/domain/providers/api_provider.dart';
import 'package:cep_app/shared/domain/providers/local_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCepDetailsByCepRemoteDataSource =
    Provider<GetCepDetailsByCepRemoteDataSource>(
  (ref) => GetCepDetailsByCepRemoteDataSourceImpl(
    ref.read<ApiService>(apiProvider),
  ),
);

final getCepDetailsByCepLocalDataSource =
    Provider<GetCepDetailsByCepLocalDataSource>(
  (ref) => GetCepDetailsByCepLocalDataSourceImpl(
    ref.read<LocalService>(localprovider),
  ),
);

final getCepDetailsByLocalDetailsRemoteDataSource =
    Provider<GetCepDetailsByLocalDetailsRemoteDataSource>(
  (ref) => GetCepDetailsByLocalDetailsRemoteDataSourceImpl(
    ref.read<ApiService>(apiProvider),
  ),
);

final getCepDetailsByLocalDetailsLocalDataSource =
    Provider<GetCepDetailsByLocalDetailsLocalDataSource>(
  (ref) => GetCepDetailsByLocalDetailsLocalDataSourceImpl(
    ref.read<LocalService>(localprovider),
  ),
);

final cepRepository = Provider<CepRepository>((ref) => CepRepositoryImpl(
      ref.read<GetCepDetailsByCepLocalDataSource>(
          getCepDetailsByCepLocalDataSource),
      ref.read<GetCepDetailsByCepRemoteDataSource>(
          getCepDetailsByCepRemoteDataSource),
      ref.read<GetCepDetailsByLocalDetailsLocalDataSource>(
          getCepDetailsByLocalDetailsLocalDataSource),
      ref.read<GetCepDetailsByLocalDetailsRemoteDataSource>(
          getCepDetailsByLocalDetailsRemoteDataSource),
    ));

final getCepDetailsByCep = Provider<GetCepDetailsByCep>(
  (ref) => GetCepDetailsByCep(
    ref.read<CepRepository>(cepRepository),
  ),
);

final getCepDetailsByLocalDetails = Provider<GetCepDetailsByLocalDetails>(
  (ref) => GetCepDetailsByLocalDetails(
    ref.read<CepRepository>(cepRepository),
  ),
);
