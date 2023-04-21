import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../../repositories/auth_repository.dart';
import 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.unknown()) {
    authSubscription = authRepository.user.listen((fbAuth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });

    on<AuthStateChangedEvent>(
      (event, emit) async {
        if (event.user != null) {
          // Check if the user is anonymous
          if (event.user!.isAnonymous) {
            emit(
              state.copyWith(
                authStatus: AuthStatus.anonymous,
                user: event.user,
              ),
            );
          } else {
            emit(
              state.copyWith(
                authStatus: AuthStatus.authenticated,
                user: event.user,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.unauthenticated,
              user: null,
            ),
          );
        }
      },
    );

    // Create a signout event
    on<SignoutRequestedEvent>(
      (event, emit) async {
        await authRepository.signout();
      },
    );

    // Create a delete account event
    on<DeleteAccountRequestedEvent>(
      (event, emit) async {
        await authRepository.deleteUserAccount(event.password).then(
          (value) {
            // emit new state
            emit(
              state.copyWith(
                authStatus: AuthStatus.unauthenticated,
                user: null,
              ),
            );
          },
        );
      },
    );
  }
}
