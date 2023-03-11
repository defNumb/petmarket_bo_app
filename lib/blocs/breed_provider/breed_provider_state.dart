part of 'breed_provider_bloc.dart';

enum BreedProviderStatus {
  initial,
  loading,
  success,
  error,
}

class BreedProviderState extends Equatable {
  final BreedProviderStatus status;
  final List<String> breeds;
  final CustomError error;
  BreedProviderState({
    required this.status,
    required this.breeds,
    required this.error,
  });

  // initial
  factory BreedProviderState.initial() {
    return BreedProviderState(
      status: BreedProviderStatus.initial,
      breeds: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, breeds, error];

  @override
  bool get stringify => true;

  BreedProviderState copyWith({
    BreedProviderStatus? status,
    List<String>? breeds,
    CustomError? error,
  }) {
    return BreedProviderState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      error: error ?? this.error,
    );
  }
}
