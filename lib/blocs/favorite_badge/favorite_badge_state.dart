// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'favorite_badge_cubit.dart';

class FavoriteBadgeState extends Equatable {
  final bool favorited;
  final String id;

  FavoriteBadgeState({
    required this.favorited,
    required this.id,
  });

  // initial
  factory FavoriteBadgeState.initial() {
    return FavoriteBadgeState(
      favorited: false,
      id: '',
    );
  }

  @override
  List<Object> get props => [favorited, id];

  @override
  bool get stringify => true;

  FavoriteBadgeState copyWith({
    bool? favorited,
    String? id,
  }) {
    return FavoriteBadgeState(
      favorited: favorited ?? this.favorited,
      id: id ?? this.id,
    );
  }
}
