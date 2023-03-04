import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petmarket_bo_app/models/favorite_model.dart';

import '../../models/custom_error.dart';
import '../../models/product_model.dart';
import '../../repositories/favorite_repository.dart';

part 'favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  // favorite repository
  final FavoriteRepository favoriteRepository;
  FavoriteListCubit({
    required this.favoriteRepository,
  }) : super(FavoriteListState.initial());

  // get favorite products from favoriteProducts()
  Future<void> getFavoriteProducts() async {
    emit(state.copyWith(status: FavoriteListStatus.loading));
    try {
      // get favorite list
      final favoriteList = await favoriteRepository.getFavoriteList();
      // get favorite products
      final favoriteProducts = await favoriteRepository.getFavoriteProducts(favoriteList);
      // emit success state
      emit(
        state.copyWith(
          favoriteList: favoriteList,
          status: FavoriteListStatus.success,
          favoriteProducts: favoriteProducts,
        ),
      );
    } catch (e) {
      // emit failure state
      emit(
        state.copyWith(
          status: FavoriteListStatus.error,
        ),
      );
    }
  }
}
