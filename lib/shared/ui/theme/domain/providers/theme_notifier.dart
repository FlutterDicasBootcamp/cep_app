import 'package:cep_app/shared/extensions/snack_bar_extension.dart';
import 'package:cep_app/shared/ui/theme/domain/providers/theme_state.dart';
import 'package:cep_app/shared/ui/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/async/either.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  final ThemeRepository _themeRepository;

  ThemeNotifier(this._themeRepository)
      : super(const ThemeState(themeStateEnum: ThemeStateEnum.light));

  Future<String?> initThemeState() async {
    final isLightThemeEither = await _themeRepository.getIsLightTheme();
    String? error;

    switch (isLightThemeEither) {
      case Left():
        {
          error = isLightThemeEither.value.message;
        }
      case Right():
        {
          state = ThemeState(
            themeStateEnum: isLightThemeEither.value
                ? ThemeStateEnum.light
                : ThemeStateEnum.dark,
          );
        }
    }
    return error;
  }

  void _toggleTheme() {
    state = ThemeState(
      themeStateEnum: state.themeStateEnum == ThemeStateEnum.dark
          ? ThemeStateEnum.light
          : ThemeStateEnum.dark,
    );
  }

  Future<void> changeTheme(BuildContext context) async {
    _toggleTheme();

    final setIsLightThemeEither = await _themeRepository
        .setIsLightTheme(state.themeStateEnum == ThemeStateEnum.light);

    switch (setIsLightThemeEither) {
      case Left():
        {
          if (context.mounted) {
            context.showSnackBar(
                SnackBarType.error, setIsLightThemeEither.value.message);
          }
        }
      case Right():
        {}
    }
  }
}
