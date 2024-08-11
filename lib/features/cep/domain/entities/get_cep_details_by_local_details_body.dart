import 'package:equatable/equatable.dart';

class GetCepDetailsByLocalDetailsBody extends Equatable {
  final String estado;
  final String cidade;
  final String rua;

  const GetCepDetailsByLocalDetailsBody({
    required this.estado,
    required this.cidade,
    required this.rua,
  });

  @override
  List<Object?> get props => [estado, cidade, rua];
}
