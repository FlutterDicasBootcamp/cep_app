import 'package:cep_app/features/cep/domain/providers/get_cep_details_provider.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_notifier.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchByLocalDetailsNotifierProvider = StateNotifierProvider<
    SearchByLocalDetailsNotifier, SearchByLocalDetailsState>((ref) {
  final getCepDetailsByLocalDetailsInstance =
      ref.read<GetCepDetailsByLocalDetails>(getCepDetailsByLocalDetails);

  return SearchByLocalDetailsNotifier(getCepDetailsByLocalDetailsInstance);
});
