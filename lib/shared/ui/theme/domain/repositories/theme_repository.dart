import 'package:cep_app/shared/data/async/either.dart';

import '../../errors/theme_local_exception.dart';

abstract interface class ThemeRepository {
  Future<Either<ThemeLocalException, bool>> getIsLightTheme();

  Future<Either<ThemeLocalException, void>> setIsLightTheme(bool isLightTheme);
}
