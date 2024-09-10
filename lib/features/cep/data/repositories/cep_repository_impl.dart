import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/local/get_cep_details_by_local_details_local_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:cep_app/features/cep/data/data_sources/remote/get_cep_details_by_local_details_remote_data_source.dart';
import 'package:cep_app/features/cep/domain/entities/cep_response.dart';
import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:cep_app/features/cep/domain/errors/cep_exception.dart';
import 'package:cep_app/features/cep/domain/repositories/cep_repository.dart';
import 'package:cep_app/shared/const/const_strings.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:cep_app/shared/data/remote/errors/no_internet_exception.dart';

class CepRepositoryImpl implements CepRepository {
  final GetCepDetailsByCepLocalDataSource _getCepByCepLocal;
  final GetCepDetailsByCepRemoteDataSource _getCepByCepRemote;

  final GetCepDetailsByLocalDetailsLocalDataSource _getCepByLocalDetailsLocal;
  final GetCepDetailsByLocalDetailsRemoteDataSource _getCepByLocalDetailsRemote;

  CepRepositoryImpl(
    this._getCepByCepLocal,
    this._getCepByCepRemote,
    this._getCepByLocalDetailsLocal,
    this._getCepByLocalDetailsRemote,
  );

  @override
  Future<Either<CepException, CepResponse>> getCepDetailsByCep(
      GetCepDetailsByCepBody cep) async {
    try {
      final cepEitherResponse = await _getCepByCepRemote(cep);

      switch (cepEitherResponse) {
        case Left(value: final l):
          return Left(l);
        case Right(value: final r):
          await _getCepByCepLocal.set(r);
          return Right(r);
      }
    } on NoInternetException {
      final localCep = await _getCepByCepLocal.get();

      return switch (localCep) {
        Left(value: final l) => Left(CepLocalException(message: l.message)),
        Right(value: final r) => Left(CepInternetConnectionException(cep: r)),
      };
    } catch (e) {
      return Left(CepException(message: ConstStrings.kDefaultErrorMessage));
    }
  }

  @override
  Future<Either<CepException, List<CepResponse>>> getCepDetailsByLocalDetails(
      GetCepDetailsByLocalDetailsBody localDetails) async {
    try {
      final cepResponseByLocalDetailsEither =
          await _getCepByLocalDetailsRemote(localDetails);

      switch (cepResponseByLocalDetailsEither) {
        case Left(value: final l):
          return Left(l);
        case Right(value: final r):
          await _getCepByLocalDetailsLocal.set(r);
          return Right(r);
      }
    } on NoInternetException {
      final localListOfCepResponse = await _getCepByLocalDetailsLocal.get();

      return switch (localListOfCepResponse) {
        Left(value: final l) => Left(CepLocalException(message: l.message)),
        Right(value: final r) =>
          Left(LocalDetailsInternetConnectionException(cepList: r))
      };
    } catch (e) {
      return Left(CepException(
        message: ConstStrings.kDefaultErrorMessage,
      ));
    }
  }
}
