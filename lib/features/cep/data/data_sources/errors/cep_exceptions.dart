import 'package:cep_app/shared/errors/base_exception.dart';

base class CepException extends BaseException {
  CepException({super.message});
}

final class CepLocalException extends CepException {
  CepLocalException({super.message});
}
