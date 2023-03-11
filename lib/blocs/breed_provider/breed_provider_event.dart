part of 'breed_provider_bloc.dart';

abstract class BreedProviderEvent extends Equatable {
  const BreedProviderEvent();

  @override
  List<Object> get props => [];
}

// get cat api event
class BreedProviderGetCatApiEvent extends BreedProviderEvent {}

// get dog api event
class BreedProviderGetDogApiEvent extends BreedProviderEvent {}

// set breeds event to initial state
class BreedProviderSetBreedsEvent extends BreedProviderEvent {}
