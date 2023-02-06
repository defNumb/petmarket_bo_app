// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'badges_cubit.dart';

enum BadgesStatus {
  initial,
  loading,
  loaded,
  error,
}

class BadgesState extends Equatable {
  final BadgesStatus badgesStatus;
  final int badgeAmount;
  BadgesState({
    required this.badgesStatus,
    required this.badgeAmount,
  });

  // Initial state
  factory BadgesState.initial() {
    return BadgesState(
      badgesStatus: BadgesStatus.initial,
      badgeAmount: 0,
    );
  }

  @override
  List<Object> get props => [badgesStatus, badgeAmount];

  @override
  bool get stringify => true;

  BadgesState copyWith({
    BadgesStatus? badgesStatus,
    int? badgeAmount,
  }) {
    return BadgesState(
      badgesStatus: badgesStatus ?? this.badgesStatus,
      badgeAmount: badgeAmount ?? this.badgeAmount,
    );
  }
}
