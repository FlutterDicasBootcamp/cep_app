import 'package:cep_app/shared/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CepTextFieldWidget extends StatelessWidget {
  final TextEditingController? textEC;
  final String? Function(String?)? validator;
  final String? placeholder;
  final FocusNode? focusNode;

  const CepTextFieldWidget({
    this.textEC,
    this.validator,
    this.placeholder,
    super.key,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      style: context.getTextTheme.bodyMedium,
      controller: textEC,
      validator: validator,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }
}
