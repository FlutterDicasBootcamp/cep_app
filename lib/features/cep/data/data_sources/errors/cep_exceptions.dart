import 'package:cep_app/shared/const/const_strings.dart';

import '../../../domain/entities/cep_response.dart';
import '../../../domain/errors/cep_exception.dart';

final class CepLocalException extends CepException {
  CepLocalException({super.message});
}

final class CepRemoteException extends CepException {
  CepRemoteException({super.message});
}

final class CepInternetConnectionException extends CepException {
  final CepResponse? cep;

  CepInternetConnectionException({this.cep})
      : super(message: ConstStrings.kNoInternetConnectionMessage);
}
