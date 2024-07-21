import "package:equatable/equatable.dart";

class CepResponse extends Equatable {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  const CepResponse({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  @override
  List<Object?> get props => [
        cep,
        logradouro,
        complemento,
        bairro,
        localidade,
        uf,
      ];
}
