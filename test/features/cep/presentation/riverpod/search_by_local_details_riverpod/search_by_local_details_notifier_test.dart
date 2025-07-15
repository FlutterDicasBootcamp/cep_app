import 'package:cep_app/features/cep/domain/errors/cep_exception.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:cep_app/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_notifier.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:cep_app/shared/const/const_strings.dart';
import 'package:cep_app/shared/data/async/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../../fixtures/cep_fixtures.dart';

class MockGetCepDetailsByLocalDetails extends Mock
    implements GetCepDetailsByLocalDetails {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late GetCepDetailsByLocalDetails mockGetCepDetailsByLocalDetails;
  late SearchByLocalDetailsNotifier searchByLocalDetailsNotifier;
  late BuildContext mockBuildContext;

  setUp(() {
    mockGetCepDetailsByLocalDetails = MockGetCepDetailsByLocalDetails();
    searchByLocalDetailsNotifier =
        SearchByLocalDetailsNotifier(mockGetCepDetailsByLocalDetails);
    mockBuildContext = MockBuildContext();

    registerFallbackValue(tGetCepDetailsByLocalDetailsBodyRight);
  });

  stateNotifierTest(
    'should not emit state when no methods are called',
    actions: (_) {},
    build: () => searchByLocalDetailsNotifier,
    expect: () => [],
  );

  group('Cep Notifier tests', () {
    final searchCepByLocalDetailsResponse = [tCepObject];
    stateNotifierTest(
      'should emit CepStateEnum.loading when function is called and CepStateEnum.loaded after loadAddressByLocalDetails is completed',
      build: () => searchByLocalDetailsNotifier,
      setUp: () {
        when(() => mockGetCepDetailsByLocalDetails(any()))
            .thenAnswer((_) async => Right(searchCepByLocalDetailsResponse));
      },
      actions: (_) {
        searchByLocalDetailsNotifier.loadAddressByLocalDetails(
            tGetCepDetailsByLocalDetailsBodyRight, mockBuildContext);
      },
      expect: () => [
        const SearchByLocalDetailsState(
          isLoading: true,
          errorMessage: null,
          state: CepStateEnum.loading,
        ),
        SearchByLocalDetailsState(
          isLoading: false,
          state: CepStateEnum.loaded,
          localDetailsList: searchCepByLocalDetailsResponse,
        ),
      ],
    );

    stateNotifierTest(
      'should emit CepStateEnum.loading when the function is called and CepStateEnum.error after loadAddressByLocalDetails is completed',
      build: () => searchByLocalDetailsNotifier,
      setUp: () {
        when(() => mockGetCepDetailsByLocalDetails(any())).thenAnswer(
          (_) async => Left(
            CepException(),
          ),
        );

        when(() => mockBuildContext.mounted).thenReturn(true);
      },
      actions: (_) async {
        searchByLocalDetailsNotifier.loadAddressByLocalDetails(
            tGetCepDetailsByLocalDetailsBodyRight, mockBuildContext);
      },
      expect: () => const [
        SearchByLocalDetailsState(
          isLoading: true,
          errorMessage: null,
          state: CepStateEnum.loading,
        ),
        SearchByLocalDetailsState(
          errorMessage: ConstStrings.kDefaultErrorMessage,
          isLoading: false,
          state: CepStateEnum.error,
        )
      ],
    );
  });
}
