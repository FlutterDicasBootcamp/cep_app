import 'package:cep_app/features/cep/domain/entities/cep_response.dart';
import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:cep_app/shared/data/async/either.dart';

import '../errors/cep_exception.dart';
import '../repositories/cep_repository.dart';

class GetCepDetailsByCep {
  final CepRepository _repository;

  GetCepDetailsByCep(this._repository);

  Future<Either<CepException, CepResponse>> call(GetCepDetailsByCepBody body) {
    return _repository.getCepDetailsByCep(body);
  }
}
