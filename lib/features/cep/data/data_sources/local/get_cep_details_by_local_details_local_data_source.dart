import 'dart:convert';

import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/local/local_service/local_service.dart';

import '../../models/cep_response_model.dart';

abstract interface class GetCepDetailsByLocalDetailsLocalDataSource {
  Future<Either<CepLocalException, List<CepResponseModel>?>> get();
  Future<Either<CepLocalException, void>> set(List<CepResponseModel> cepList);
}

const GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY = 'GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY';

class GetCepDetailsByLocalDetailsLocalDataSourceImpl
    implements GetCepDetailsByLocalDetailsLocalDataSource {
  final LocalService _sharedPreferences;

  GetCepDetailsByLocalDetailsLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<Either<CepLocalException, List<CepResponseModel>?>> get() async {
    final localCep = await _sharedPreferences
        .get<String>(GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY);

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right(value: final r) => Right(r != null
          ? (jsonDecode(r) as List)
              .map((cepResponse) => CepResponseModel.fromMap(cepResponse))
              .toList()
          : null),
    };
  }

  @override
  Future<Either<CepLocalException, void>> set(
      List<CepResponseModel> cepResponseList) async {
    final cepResponseListLocalResult = await _sharedPreferences.set<String>(
      GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY,
      jsonEncode(
          cepResponseList.map((cepResponse) => cepResponse.toMap()).toList()),
    );

    return switch (cepResponseListLocalResult) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right() => Right(null),
    };
  }
}
