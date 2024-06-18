import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeStateEnum { light, dark }

class ThemeState extends Equatable {
  final ThemeStateEnum themeStateEnum;

  const ThemeState({this.themeStateEnum = ThemeStateEnum.light});

  ThemeMode get getTheme =>
      themeStateEnum == ThemeStateEnum.light ? ThemeMode.light : ThemeMode.dark;

  @override
  List<Object?> get props => [themeStateEnum];
}
