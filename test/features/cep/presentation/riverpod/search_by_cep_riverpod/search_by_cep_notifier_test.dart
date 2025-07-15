import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:cep_app/features/cep/domain/errors/cep_exception.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:cep_app/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_notifier.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_state.dart';
import 'package:cep_app/shared/const/const_strings.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../../fixtures/cep_fixtures.dart';

class MockGetCepDetailsByCep extends Mock implements GetCepDetailsByCep {}

class MockBuildContext extends Mock implements BuildContext {}

const cepBody = GetCepDetailsByCepBody(cep: '000000000');

void main() {
  late GetCepDetailsByCep getCepDetailsByCepMock;
  late SearchByCepNotifier cepNotifier;
  late BuildContext buildContextMock;

  setUp(() {
    getCepDetailsByCepMock = MockGetCepDetailsByCep();
    cepNotifier = SearchByCepNotifier(getCepDetailsByCepMock);
    buildContextMock = MockBuildContext();

    registerFallbackValue(cepBody);
  });

  stateNotifierTest<SearchByCepNotifier, SearchByCepState>(
    'should emit CepStateEnum.loading when function is evoked and CepStateEnum.loaded after loadAddressByCep is completed',
    build: () => cepNotifier,
    setUp: () {
      when(() => getCepDetailsByCepMock(any()))
          .thenAnswer((_) async => Right(tCepObject));
    },
    actions: (_) async {
      await cepNotifier.loadAddressByCep(cepBody, buildContextMock);
    },
    expect: () => const [
      SearchByCepState(isLoading: true, state: CepStateEnum.loading),
      SearchByCepState(
        cep: tCepObject,
        isLoading: false,
        state: CepStateEnum.loaded,
      ),
    ],
  );

  stateNotifierTest<SearchByCepNotifier, SearchByCepState>(
    'should emit CepStateEnum.loading when the function is evoked and CepStateEnum.error after loadAddressByCep is completed',
    build: () => cepNotifier,
    setUp: () {
      when(() => getCepDetailsByCepMock(any())).thenAnswer(
        (_) async => Left(
          CepException(),
        ),
      );
      when(() => buildContextMock.mounted).thenReturn(true);
    },
    actions: (_) async {
      await cepNotifier.loadAddressByCep(cepBody, buildContextMock);
    },
    expect: () => const [
      SearchByCepState(
        isLoading: true,
        state: CepStateEnum.loading,
      ),
      SearchByCepState(
        errorMessage: ConstStrings.kDefaultErrorMessage,
        isLoading: false,
        state: CepStateEnum.error,
      )
    ],
  );
}
