import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/brand_model.dart';
import '../../models/custom_error.dart';
import '../../repositories/brand_repository.dart';

part 'brand_list_state.dart';

class BrandListCubit extends Cubit<BrandListState> {
  final BrandRepository brandRepository;
  BrandListCubit({required this.brandRepository}) : super(BrandListState.initial());

  // get brand list
  Future<List<Brand>> getBrandList() async {
    try {
      final List<Brand> brandList = await brandRepository.getBrandList();
      emit(
        state.copyWith(
          status: BrandListStatus.loaded,
          brands: brandList,
        ),
      );
      return brandList;
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: BrandListStatus.error,
          error: e,
        ),
      );
      return [];
    }
  }
}
