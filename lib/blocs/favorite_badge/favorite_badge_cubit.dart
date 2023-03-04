// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:petmarket_bo_app/repositories/favorite_repository.dart';

import '../../models/favorite_model.dart';

part 'favorite_badge_state.dart';

class FavoriteBadgeCubit extends Cubit<FavoriteBadgeState> {
  // favorite repository
  final FavoriteRepository favoriteRepository;

  FavoriteBadgeCubit({
    required this.favoriteRepository,
  }) : super(FavoriteBadgeState.initial());

  // add favorite
  Future<void> addFavorite({required Favorite favorite}) async {
    try {
      // add favorite to firebase
      await favoriteRepository.addFavorite(favorite: favorite);
      emit(
        state.copyWith(favorited: true, id: favorite.id),
      );
    } catch (e) {
      emit(
        state.copyWith(favorited: false, id: favorite.id),
      );
    }
  }

  // remove favorite
  Future<void> removeFavorite(String id) async {
    try {
      // remove favorite from firebase
      await favoriteRepository.deleteFavorite(fid: id);
      emit(
        state.copyWith(favorited: true, id: id),
      );
    } catch (e) {
      emit(
        state.copyWith(favorited: false, id: id),
      );
    }
  }

  // check if favorite exist
  Future<void> checkFavorite({required id}) async {
    try {
      // call isFavorite from favorite repository
      final isFavorite = await favoriteRepository.isFavorite(fid: id);

      if (isFavorite == true) {
        emit(
          state.copyWith(favorited: true, id: id),
        );
      } else {
        emit(
          state.copyWith(favorited: false, id: id),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(favorited: false, id: id),
      );
    }
  }
}
