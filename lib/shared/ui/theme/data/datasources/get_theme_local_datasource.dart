import 'package:cep_app/shared/data/local/local_service/local_service.dart';
import 'package:cep_app/shared/ui/theme/errors/theme_local_exception.dart';

import '../../../../data/async/either.dart';

abstract interface class GetThemeLocalDatasource {
  Future<Either<ThemeLocalException, bool>> getIsLightTheme();
}

const IS_LIGHT_THEME_KEY = 'IS_LIGHT_THEME_KEY';

final class GetThemeLocalDatasourceImpl implements GetThemeLocalDatasource {
  final LocalService _localService;

  GetThemeLocalDatasourceImpl(this._localService);

  @override
  Future<Either<ThemeLocalException, bool>> getIsLightTheme() async {
    final isLightTheme = await _localService.get<bool>(IS_LIGHT_THEME_KEY);

    switch (isLightTheme) {
      case Left():
        return Left(ThemeLocalException(message: 'Erro ao trocar tema.'));
      case Right(value: final r):
        return Right(r ?? true);
    }
  }
}
