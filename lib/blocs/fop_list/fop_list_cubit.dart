import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petmarket_bo_app/repositories/fop_repository.dart';
import '../../models/custom_error.dart';
import '../../models/fop_model.dart';

part 'fop_list_state.dart';

class FopListCubit extends Cubit<FopListState> {
  final FopRepository fopRepository;

  FopListCubit({required this.fopRepository}) : super(FopListState.initial());

  // Get fop list
  Future<List<FormOfPayment>> getFopList() async {
    emit(state.copyWith(listStatus: FopListStatus.loading));
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final List<FormOfPayment> fopList = await fopRepository.getFopList(uid: uid);
      emit(
        state.copyWith(
          listStatus: FopListStatus.loaded,
          fopList: fopList,
        ),
      );
      return fopList;
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: FopListStatus.error,
          error: e,
        ),
      );
      return [];
    }
  }

  // Update fop list
  void updateFopList() async {
    emit(state.copyWith(listStatus: FopListStatus.loading));
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final List<FormOfPayment> fopList = await fopRepository.getFopList(uid: uid);
      emit(
        state.copyWith(
          listStatus: FopListStatus.loaded,
          fopList: fopList,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          listStatus: FopListStatus.error,
          error: e,
        ),
      );
    }
  }
}
