// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signup_in_switch_cubit.dart';

// switch between signup and signin enum
enum SignupInSwitchStatus { signup, signin }

class SignupInSwitchState extends Equatable {
  // status
  final SignupInSwitchStatus status;
  SignupInSwitchState({
    required this.status,
  });

  // initial status
  factory SignupInSwitchState.initial() {
    return SignupInSwitchState(
      status: SignupInSwitchStatus.signin,
    );
  }
  @override
  List<Object> get props => [status];

  @override
  bool get stringify => true;

  SignupInSwitchState copyWith({
    SignupInSwitchStatus? status,
  }) {
    return SignupInSwitchState(
      status: status ?? this.status,
    );
  }
}
