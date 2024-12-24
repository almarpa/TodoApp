import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/data/repository/user_repository.dart';
import 'package:todo_app/app/presentation/screens/auth/bloc/auth_event.dart';
import 'package:todo_app/app/presentation/screens/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> userStream;

  AuthBloc({required this.userRepository}) : super(AuthState.unknown()) {
    userStream = userRepository.user.listen((user) async {
      add(AuthUserChanged(user));
    });

    on<AuthUserChanged>((event, emit) {
      if (event.user != null && !event.user!.emailVerified) {
        emit(NotVerified());
      } else if (event.user != null) {
        emit(Authenticated(event.user!));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    userStream.cancel();
    return super.close();
  }
}
