// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'bottom_nav_bar_cubit.dart';

enum BottomNavBarItem {
  discover,
  shop,
  petfind,
  myaccount,
  menu,
}

class BottomNavBarState extends Equatable {
  final BottomNavBarItem navBarItem;
  final int index;
  BottomNavBarState({
    required this.navBarItem,
    required this.index,
  });

  // initial state
  factory BottomNavBarState.initial() {
    return BottomNavBarState(
      navBarItem: BottomNavBarItem.discover,
      index: 0,
    );
  }

  @override
  List<Object> get props => [navBarItem, index];

  @override
  bool get stringify => true;

  BottomNavBarState copyWith({
    BottomNavBarItem? navBarItem,
    int? index,
  }) {
    return BottomNavBarState(
      navBarItem: navBarItem ?? this.navBarItem,
      index: index ?? this.index,
    );
  }
}
