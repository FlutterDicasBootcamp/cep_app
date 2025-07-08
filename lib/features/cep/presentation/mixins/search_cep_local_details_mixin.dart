import 'package:flutter/material.dart';

mixin SearchCepLocalDetailsMixin {
  final estadoTEC = TextEditingController();
  final cidadeTEC = TextEditingController();
  final ruaTEC = TextEditingController();

  final estadoFN = FocusNode();
  final cidadeFN = FocusNode();
  final ruaFN = FocusNode();

  void disposeTECandFN() {
    estadoTEC.dispose();
    cidadeTEC.dispose();
    ruaTEC.dispose();

    estadoFN.dispose();
    cidadeFN.dispose();
    ruaFN.dispose();
  }
}
