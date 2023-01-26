import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petmarket_bo_app/models/custom_error.dart';
import 'package:petmarket_bo_app/models/pet_model.dart';
import 'package:petmarket_bo_app/models/user_model.dart';
import 'package:petmarket_bo_app/repositories/pet_repository.dart';
import 'package:petmarket_bo_app/repositories/profile_repository.dart';

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
}
