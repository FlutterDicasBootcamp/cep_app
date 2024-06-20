import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/ui/theme/data/datasources/get_theme_local_datasource.dart';
import 'package:cep_app/shared/ui/theme/data/datasources/set_theme_local_datasource.dart';
import 'package:cep_app/shared/ui/theme/domain/repositories/theme_repository.dart';
import 'package:cep_app/shared/ui/theme/errors/theme_local_exception.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final SetThemeLocalDatasource _setThemeLocalDatasource;
  final GetThemeLocalDatasource _getThemeLocalDatasource;

  ThemeRepositoryImpl(
      this._getThemeLocalDatasource, this._setThemeLocalDatasource);

  @override
  Future<Either<ThemeLocalException, bool>> getIsLightTheme() {
    return _getThemeLocalDatasource.getIsLightTheme();
  }

  @override
  Future<Either<ThemeLocalException, void>> setIsLightTheme(bool isLightTheme) {
    return _setThemeLocalDatasource.setIsLightTheme(isLightTheme);
  }
}
