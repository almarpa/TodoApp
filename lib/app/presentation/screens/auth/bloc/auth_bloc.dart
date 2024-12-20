import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required this.userRepository}) : super(const AuthState.unknown()) {
    _userSubscription = userRepository.user.listen((user) async {
      add(AuthUserChanged(user));
    });
    on<AuthUserChanged>((event, emit) {
      if (event.user != null && !event.user!.emailVerified) {
        emit(const AuthState.notVerified());
      } else if (event.user != null) {
        emit(AuthState.authenticated(event.user!));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}