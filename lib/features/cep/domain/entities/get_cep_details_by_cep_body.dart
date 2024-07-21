import 'package:equatable/equatable.dart';

class GetCepDetailsByCepBody extends Equatable {
  final String cep;

  const GetCepDetailsByCepBody({required this.cep});

  @override
  List<Object?> get props => [cep];
}
