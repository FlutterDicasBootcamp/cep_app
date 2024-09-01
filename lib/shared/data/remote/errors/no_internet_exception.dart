import 'package:cep_app/shared/const/const_strings.dart';
import 'package:cep_app/shared/errors/base_exception.dart';

final class NoInternetException extends BaseException {
  NoInternetException({
    super.message = ConstStrings.kNoInternetConnectionMessage,
  });
}
