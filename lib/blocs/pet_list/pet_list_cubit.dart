import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petmarket_bo_app/models/custom_error.dart';
import 'package:petmarket_bo_app/models/pet_model.dart';
import 'package:petmarket_bo_app/repositories/pet_repository.dart';

part 'pet_list_state.dart';

class PetListCubit extends Cubit<PetListState> {
  final PetRepository petRepository;
  PetListCubit({required this.petRepository}) : super(PetListState.initial());

  // Get pet list
  Future<List<Pet>> getPetList({required String uid}) async {
    try {
      final List<Pet> petList = await petRepository.getPetList(uid: uid);
      emit(
        state.copyWith(
          listStatus: PetListStatus.loaded,
          petList: petList,
        ),
      );
      return petList;
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: PetListStatus.error,
          error: e,
        ),
      );
      return [];
    }
  }

  // Update pet list
  void updatePetList({required String uid}) async {
    try {
      final List<Pet> petList = await petRepository.getPetList(uid: uid);
      emit(
        state.copyWith(
          listStatus: PetListStatus.updated,
          petList: petList,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: PetListStatus.error,
          error: e,
        ),
      );
    }
  }
}
