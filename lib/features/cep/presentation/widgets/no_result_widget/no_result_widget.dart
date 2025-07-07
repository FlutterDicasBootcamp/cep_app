import 'package:cep_app/shared/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class NoResultWidget extends StatelessWidget {
  final String text;

  const NoResultWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.getTextTheme.bodyMedium);
  }
}
