import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get getTheme => Theme.of(this);

  TextTheme get getTextTheme => getTheme.textTheme;
}
