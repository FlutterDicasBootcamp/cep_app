import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';

import '../../../../shared/data/async/either.dart';
import '../entities/cep_response.dart';
import '../entities/get_cep_details_by_cep_body.dart';
import '../errors/cep_exception.dart';

abstract interface class CepRepository {
  Future<Either<CepException, CepResponse>> getCepDetailsByCep(
      GetCepDetailsByCepBody body);

  Future<Either<CepException, List<CepResponse>>> getCepDetailsByLocalDetails(
      GetCepDetailsByLocalDetailsBody body);
}
