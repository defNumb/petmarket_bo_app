import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/pet_model.dart';
import '../../repositories/pet_repository.dart';

part 'signup_pet_state.dart';

class SignupPetCubit extends Cubit<SignupPetState> {
  final PetRepository petRepository;

  SignupPetCubit({required this.petRepository})
      : super(
          SignupPetState.initial(),
        );

  Future<void> createPet({
    required Pet pet,
    required String uid,
  }) async {
    emit(state.copyWith(signupPetStatus: SignupPetStatus.submitting));
    try {
      await petRepository.createPet(pet,uid);
      emit(state.copyWith(signupPetStatus: SignupPetStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signupPetStatus: SignupPetStatus.error,
          error: e,
        ),
      );
    }
  }
}
