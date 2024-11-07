import 'package:cep_app/features/cep/data/data_sources/errors/cep_exceptions.dart';
import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:cep_app/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_state.dart';
import 'package:cep_app/shared/extensions/snack_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/data/async/either.dart';

final class SearchByCepNotifier extends StateNotifier<SearchByCepState> {
  final GetCepDetailsByCep _getCepDetailsByCep;

  SearchByCepNotifier(this._getCepDetailsByCep)
      : super(const SearchByCepState.initial());

  bool get isLoading => state.isLoading;

  Future<void> loadAddressByCep(
      GetCepDetailsByCepBody cep, BuildContext context) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      state: CepStateEnum.loading,
    );

    final cepEither = await _getCepDetailsByCep(cep);

    switch (cepEither) {
      case Left(value: final l):
        {
          final noInternetError = l is CepInternetConnectionException;

          if (noInternetError && context.mounted) {
            context.showSnackBar(SnackBarType.error, l.message);
          }

          state = state.copyWith(
            isLoading: false,
            state: noInternetError ? CepStateEnum.loaded : CepStateEnum.error,
            errorMessage: noInternetError ? null : l.message,
            cep: noInternetError ? l.cep : null,
          );
        }
      case Right(value: final r):
        {
          state = state.copyWith(
            isLoading: false,
            state: CepStateEnum.loaded,
            cep: r,
          );
        }
    }
  }
}
