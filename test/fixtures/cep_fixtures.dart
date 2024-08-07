import 'package:cep_app/features/cep/domain/entities/cep_response.dart';
import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_cep_body.dart';

const tCepObject = CepResponse(
    cep: '589389032',
    logradouro: 'logradouro',
    complemento: 'complemento',
    bairro: 'bairro',
    localidade: 'localidade',
    uf: 'uf');

const tGetCepDetailsByCepBodyRight = GetCepDetailsByCepBody(cep: '589389032');
