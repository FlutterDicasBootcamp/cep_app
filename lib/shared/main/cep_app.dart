import 'package:cep_app/shared/main/cep_config.dart';
import 'package:cep_app/shared/ui/theme/cep_app_theme.dart';
import 'package:flutter/material.dart';

class CepApp extends StatelessWidget {
  const CepApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CepConfig.title,
      theme: CepAppTheme.light,
      darkTheme: CepAppTheme.dark,
      themeMode: ThemeMode.dark,
      home: Container(),
    );
  }
}
