import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petmarket_bo_app/models/custom_error.dart';
import 'package:petmarket_bo_app/models/pet_model.dart';
import 'package:petmarket_bo_app/repositories/pet_repository.dart';

part 'signup_pet_state.dart';

class SignupPetCubit extends Cubit<SignupPetState> {
  final PetRepository petRepository;

  SignupPetCubit({required this.petRepository})
      : super(
          SignupPetState.initial(),
        );

  Future<void> signup({
    required Pet pet,
  }) async {
    emit(state.copyWith(signupPetStatus: SignupPetStatus.submitting));
    try {
      await petRepository.createPet(pet);
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
