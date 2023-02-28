import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_in_switch_state.dart';

class SignupInSwitchCubit extends Cubit<SignupInSwitchState> {
  SignupInSwitchCubit() : super(SignupInSwitchState.initial());
  // switch between signup
  void switchToSignup() {
    emit(state.copyWith(status: SignupInSwitchStatus.signup));
  }

  // switch between signin
  void switchToSignin() {
    emit(state.copyWith(status: SignupInSwitchStatus.signin));
  }
}
