import 'package:cep_app/features/cep/domain/entities/cep_response.dart';
import 'package:cep_app/features/cep/presentation/riverpod/base_cep_app_state.dart';

final class SearchByLocalDetailsState extends BaseCepAppState {
  final List<CepResponse>? localDetailsList;

  const SearchByLocalDetailsState({
    super.isLoading = false,
    super.state = CepStateEnum.initial,
    super.errorMessage,
    this.localDetailsList,
  });

  const SearchByLocalDetailsState.initial({
    super.isLoading = false,
    super.state = CepStateEnum.initial,
    super.errorMessage,
    this.localDetailsList,
  });

  @override
  List<Object?> get props => [
        isLoading,
        state,
        errorMessage,
        localDetailsList,
      ];

  @override
  SearchByLocalDetailsState copyWith({
    bool? isLoading,
    CepStateEnum? state,
    String? errorMessage,
    List<CepResponse>? localDetailsList,
  }) =>
      SearchByLocalDetailsState(
        isLoading: isLoading ?? this.isLoading,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
        localDetailsList: localDetailsList ?? this.localDetailsList,
      );
}
