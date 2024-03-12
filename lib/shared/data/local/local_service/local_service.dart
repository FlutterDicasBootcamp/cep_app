import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/local/local_service/errors/local_exception.dart';

abstract interface class LocalService {
  Future<Either<LocalException, T?>> get<T>(String key);

  Future<Either<LocalException, void>> set<T>(String key, T data);
}
