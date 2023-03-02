// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pet_profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
  deleted,
}

class PetState extends Equatable {
  final ProfileStatus profileStatus;
  final Pet pet;
  final CustomError error;
  PetState({
    required this.profileStatus,
    required this.pet,
    required this.error,
  });

  factory PetState.initial() {
    return PetState(
      profileStatus: ProfileStatus.initial,
      pet: Pet.initialPet(),
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [profileStatus, pet, error];

  @override
  bool get stringify => true;

  PetState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    Pet? pet,
    CustomError? error,
  }) {
    return PetState(
      profileStatus: profileStatus ?? this.profileStatus,
      pet: pet ?? this.pet,
      error: error ?? this.error,
    );
  }
}
