import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/local/local_service/local_service.dart';

import '../../models/cep_response_model.dart';
import '../errors/cep_exceptions.dart';

abstract interface class GetCepDetailsByCepLocalDataSource {
  Future<Either<CepLocalException, CepResponseModel?>> get();

  Future<Either<CepLocalException, void>> set(CepResponseModel cep);
}

const GET_CEP_BY_CEP_LOCAL_KEY = "GET_CEP_BY_CEP_LOCAL_KEY";

class GetCepDetailsByCepLocalDataSourceImpl
    implements GetCepDetailsByCepLocalDataSource {
  final LocalService _localService;

  GetCepDetailsByCepLocalDataSourceImpl(this._localService);

  @override
  Future<Either<CepLocalException, CepResponseModel?>> get() async {
    final localCep = await _localService.get<String>(GET_CEP_BY_CEP_LOCAL_KEY);

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right(value: final r) =>
        Right(r != null ? CepResponseModel.fromJson(r) : null),
    };
  }

  @override
  Future<Either<CepLocalException, void>> set(CepResponseModel cep) async {
    final localCep =
        await _localService.set<String>(GET_CEP_BY_CEP_LOCAL_KEY, cep.toJSON());

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right() => Right(null)
    };
  }
}
