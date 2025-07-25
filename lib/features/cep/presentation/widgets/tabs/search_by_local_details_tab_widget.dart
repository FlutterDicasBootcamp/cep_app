import 'package:cep_app/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:cep_app/features/cep/presentation/const/validation_messages_const.dart';
import 'package:cep_app/features/cep/presentation/mixins/search_cep_local_details_mixin.dart';
import 'package:cep_app/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/local_details_notifier_provider.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_notifier.dart';
import 'package:cep_app/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:cep_app/features/cep/presentation/widgets/buttons/cep_button_widget.dart';
import 'package:cep_app/features/cep/presentation/widgets/inputs/cep_text_field_widget.dart';
import 'package:cep_app/features/cep/presentation/widgets/no_result_widget/no_result_widget.dart';
import 'package:cep_app/shared/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Key searchZipCodeByLocalDetailsButtonKey =
    Key('searchZipCodeByLocalDetailsButtonKey');

class SearchByLocalDetailsTabWidget extends ConsumerStatefulWidget {
  const SearchByLocalDetailsTabWidget({super.key});

  @override
  ConsumerState<SearchByLocalDetailsTabWidget> createState() =>
      _SearchByLocalDetailsTabWidgetState();
}

class _SearchByLocalDetailsTabWidgetState
    extends ConsumerState<SearchByLocalDetailsTabWidget>
    with SearchCepLocalDetailsMixin {
  final formKey = GlobalKey<FormState>();

  void onSearchByLocalDetails(SearchByLocalDetailsNotifier notifier) {
    if (formKey.currentState!.validate()) {
      final body = GetCepDetailsByLocalDetailsBody(
        estado: estadoTEC.text,
        cidade: cidadeTEC.text,
        rua: ruaTEC.text,
      );

      notifier.loadAddressByLocalDetails(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref
        .watch<SearchByLocalDetailsState>(searchByLocalDetailsNotifierProvider);
    final notifier = ref.watch<SearchByLocalDetailsNotifier>(
        searchByLocalDetailsNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Text(
                'Insira um Local:',
                style: context.getTextTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: estadoTEC,
                focusNode: estadoFN,
                placeholder: 'Estado',
                validator: (String? estado) {
                  if (estado == null || estado.isEmpty) {
                    return ValidationMessagesConst.notEmpty('Estado');
                  } else if (estado.length > 2) {
                    return ValidationMessagesConst.length('Estado', 2);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: cidadeTEC,
                focusNode: cidadeFN,
                placeholder: 'Cidade',
                validator: (String? cidade) {
                  if (cidade == null || cidade.isEmpty) {
                    return ValidationMessagesConst.notEmpty('Cidade');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: ruaTEC,
                focusNode: ruaFN,
                placeholder: 'Rua',
                validator: (String? rua) {
                  if (rua == null || rua.isEmpty) {
                    return ValidationMessagesConst.notEmpty('Rua');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              CepButtonWidget(
                key: searchZipCodeByLocalDetailsButtonKey,
                label: 'Procurar',
                onPressed: () {
                  if (state.state == CepStateEnum.loading) {
                    return;
                  }

                  FocusScope.of(context).requestFocus(FocusNode());

                  onSearchByLocalDetails(notifier);
                },
              ),
              const SizedBox(height: 16),
              switch (state.state) {
                CepStateEnum.error => Text(state.errorMessage!),
                CepStateEnum.loading => const CircularProgressIndicator(),
                CepStateEnum.loaded => Column(
                    children: [
                      const SizedBox(height: 32),
                      Text('Resultados:',
                          style: context.getTextTheme.titleLarge),
                      const SizedBox(height: 32),
                      Column(
                        children: state.localDetailsList
                                ?.map((localDetailsItem) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Column(
                                        children: [
                                          Text(localDetailsItem.cep),
                                          const SizedBox(height: 8),
                                          Text(localDetailsItem.localidade),
                                          const SizedBox(height: 8),
                                          Text(localDetailsItem.bairro),
                                          const SizedBox(height: 8),
                                          Text(localDetailsItem.uf),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                    ],
                  ),
                CepStateEnum.initial => const SizedBox.shrink(),
                CepStateEnum.noResult => const NoResultWidget(
                    text: 'Sem resultados, tente outro local.'),
              },
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
