import 'package:cep_app/features/cep/domain/providers/get_cep_details_provider.dart';
import 'package:cep_app/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchByCepNotifierProvider = StateNotifierProvider((ref) {
  final getCepDetailsByCepInstance =
      ref.read<GetCepDetailsByCep>(getCepDetailsByCep);

  return SearchByCepNotifier(getCepDetailsByCepInstance);
});
