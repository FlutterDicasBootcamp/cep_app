import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:cep_app/features/cep/presentation/cep_tec_mixin.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/cep_notifier_provider.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_notifier.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_state.dart';
import 'package:cep_app/shared/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchByCepTabWidget extends ConsumerStatefulWidget {
  const SearchByCepTabWidget({super.key});

  @override
  ConsumerState<SearchByCepTabWidget> createState() =>
      _SearchByCepTabWidgetState();
}

class _SearchByCepTabWidgetState extends ConsumerState<SearchByCepTabWidget>
    with CepTECMixin {
  final cepInputFN = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    onDispose();
    cepInputFN.dispose();
    super.dispose();
  }

  void onSearchCep() {
    final notifier =
        ref.read<SearchByCepNotifier>(searchByCepNotifierProvider.notifier);

    if (formKey.currentState!.validate()) {
      notifier.loadAddressByCep(
          GetCepDetailsByCepBody(cep: cepTEC.text), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch<SearchByCepState>(searchByCepNotifierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Insira um CEP', style: context.getTextTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
