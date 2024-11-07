import 'package:equatable/equatable.dart';

enum CepStateEnum { initial, loading, loaded, error, noResult }

base class BaseCepAppState extends Equatable {
  final bool isLoading;
  final CepStateEnum state;
  final String? errorMessage;

  const BaseCepAppState({
    this.isLoading = false,
    this.state = CepStateEnum.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, state, errorMessage];

  BaseCepAppState copyWith({
    bool? isLoading,
    CepStateEnum? state,
    String? errorMessage,
  }) =>
      BaseCepAppState(
        isLoading: isLoading ?? this.isLoading,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
