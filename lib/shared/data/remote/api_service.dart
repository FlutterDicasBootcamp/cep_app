import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/remote/errors/api_exception.dart';

import '../models/api_response_model.dart';

abstract interface class ApiService {
  Future<Either<ApiException, ApiResponseModel>> get(String endPoint,
      {Map<String, dynamic>? queryParams});
}
