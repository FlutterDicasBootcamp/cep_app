import 'package:flutter/material.dart';

mixin CepTECMixin {
  final cepTEC = TextEditingController();

  void onDispose() {
    cepTEC.dispose();
  }
}
