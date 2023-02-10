import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/pet_model.dart';
import '../../models/user_model.dart';
import '../../repositories/pet_repository.dart';
import '../../repositories/profile_repository.dart';

part 'pet_profile_state.dart';

class PetProfileCubit extends Cubit<PetState> {
  final ProfileRepository profileRepository;
  final PetRepository petRepository;
  PetProfileCubit({required this.petRepository, required this.profileRepository})
      : super(PetState.initial());

  // Get pet profile
  Future<void> getProfile({required String uid, required String pid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final Pet pet = await petRepository.getPetProfile(uid: uid, pid: pid);
      final User user = await profileRepository.getProfile(uid: uid);
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.loaded,
          user: user,
          pet: pet,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.error,
          error: e,
        ),
      );
    }
  }

  // Delete pet profile
  Future<void> deletePetProfile({required String uid, required String pid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      await petRepository.deletePet(uid: uid, pid: pid);
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.deleted,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.error,
          error: e,
        ),
      );
    }
  }
}
