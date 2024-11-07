import 'package:cep_app/features/cep/domain/entities/cep_response.dart';
import 'package:cep_app/features/cep/presentation/riverpod/base_cep_app_state.dart';

final class SearchByCepState extends BaseCepAppState {
  final CepResponse? cep;

  const SearchByCepState({
    this.cep,
    super.isLoading,
    super.state,
    super.errorMessage,
  });

  const SearchByCepState.initial({
    this.cep,
    super.isLoading = false,
    super.state = CepStateEnum.initial,
    super.errorMessage,
  });

  @override
  List<Object?> get props => [
        cep,
        isLoading,
        state,
        errorMessage,
      ];

  @override
  SearchByCepState copyWith({
    CepResponse? cep,
    bool? isLoading,
    CepStateEnum? state,
    String? errorMessage,
  }) =>
      SearchByCepState(
        cep: cep ?? this.cep,
        isLoading: isLoading ?? this.isLoading,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
