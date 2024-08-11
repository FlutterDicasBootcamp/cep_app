import 'dart:convert';

import 'package:cep_app/features/cep/domain/entities/cep_response.dart';

class CepResponseModel extends CepResponse {
  const CepResponseModel({
    required super.cep,
    required super.logradouro,
    required super.complemento,
    required super.bairro,
    required super.localidade,
    required super.uf,
  });

  factory CepResponseModel.fromMap(map) {
    return CepResponseModel(
      cep: map['cep'],
      logradouro: map['logradouro'],
      complemento: map['complemento'],
      bairro: map['bairro'],
      localidade: map['localidade'],
      uf: map['uf'],
    );
  }

  factory CepResponseModel.fromJson(String json) {
    return CepResponseModel.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }

  String toJSON() => jsonEncode(toMap());
}
