import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState.initial());

  // switch/case for bottom nav bar
  void switchNavBarItem(BottomNavBarItem navbarItem) {
    switch (navbarItem) {
      case BottomNavBarItem.discover:
        emit(
          state.copyWith(
            navBarItem: BottomNavBarItem.discover,
            index: 0,
          ),
        );
        break;
      case BottomNavBarItem.shop:
        emit(
          state.copyWith(
            navBarItem: BottomNavBarItem.shop,
            index: 1,
          ),
        );
        break;
      case BottomNavBarItem.petfind:
        emit(
          state.copyWith(
            navBarItem: BottomNavBarItem.petfind,
            index: 2,
          ),
        );
        break;
      case BottomNavBarItem.myaccount:
        emit(
          state.copyWith(
            navBarItem: BottomNavBarItem.myaccount,
            index: 3,
          ),
        );
        break;
      case BottomNavBarItem.menu:
        emit(
          state.copyWith(
            navBarItem: BottomNavBarItem.menu,
            index: 4,
          ),
        );
        break;
    }
  }
}
