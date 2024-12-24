import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.unknown() = Unknown;
  factory AuthState.authenticated(User user) = Authenticated;
  factory AuthState.unauthenticated() = Unauthenticated;
  factory AuthState.notVerified() = NotVerified;

  const AuthState._();

  User? get user => maybeWhen(
        authenticated: (user) => user,
        orElse: () => null,
      );
}
