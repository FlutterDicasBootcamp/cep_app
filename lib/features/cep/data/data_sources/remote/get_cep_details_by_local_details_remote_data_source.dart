import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/features/cep/data/models/cep_response_model.dart';
import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/remote/api_service.dart';
import 'package:cep_app/shared/data/remote/errors/api_exception.dart';
import 'package:cep_app/shared/data/remote/errors/no_internet_exception.dart';

abstract interface class GetCepDetailsByLocalDetailsRemoteDataSource {
  Future<Either<CepRemoteException, List<CepResponseModel>>> call(
      GetCepDetailsByLocalDetailsBody localDetailsBody);
}

class GetCepDetailsByLocalDetailsRemoteDataSourceImpl
    implements GetCepDetailsByLocalDetailsRemoteDataSource {
  final ApiService _api;

  GetCepDetailsByLocalDetailsRemoteDataSourceImpl(this._api);

  @override
  Future<Either<CepRemoteException, List<CepResponseModel>>> call(
      GetCepDetailsByLocalDetailsBody localDetailsBody) async {
    final cepDetailsByLocalDetailsEither = await _api.get(
        '/${localDetailsBody.estado}/${localDetailsBody.cidade}/${localDetailsBody.rua}/json/');

    switch (cepDetailsByLocalDetailsEither) {
      case Left(value: final l):
        return switch (l.errorStatus) {
          ErrorStatus.noConnection => throw NoInternetException(),
          ErrorStatus.badRequest =>
            Left(CepRemoteException(message: l.message!)),
          _ => Left(CepRemoteException(message: l.message))
        };
      case Right(value: final r):
        return Right((r.data as List)
            .map((cepResponse) => CepResponseModel.fromMap(cepResponse))
            .toList());
    }
  }
}
