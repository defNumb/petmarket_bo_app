// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:petmarket_bo_app/models/fop_model.dart';

import '../../models/custom_error.dart';
import '../../repositories/fop_repository.dart';

part 'add_fop_state.dart';

class AddFopCubit extends Cubit<AddFopState> {
  // fop repository
  final FopRepository fopRepository;
  AddFopCubit({
    required this.fopRepository,
  }) : super(AddFopState.initial());

  // add fop to firebase
  Future<void> addFop(FormOfPayment fop) async {
    // emit submitting state
    emit(state.copyWith(status: AddFopStatus.submitting));
    try {
      await fopRepository.addFop(fop);
      emit(
        state.copyWith(
          status: AddFopStatus.success,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: AddFopStatus.error,
          error: e,
        ),
      );
    }
  }

  // delete fop from firebase
  Future<void> deleteFop(String fopId) async {
    // emit submitting state
    emit(state.copyWith(status: AddFopStatus.submitting));
    try {
      await fopRepository.deleteFop(fopId);
      emit(
        state.copyWith(
          status: AddFopStatus.success,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: AddFopStatus.error,
          error: e,
        ),
      );
    }
  }
}
