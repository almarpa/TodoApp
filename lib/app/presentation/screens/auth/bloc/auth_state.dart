part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, notVerified, unknown }

class AuthState extends Equatable {
  const AuthState._({this.status = AuthStatus.unknown, this.user});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.notVerified() : this._(status: AuthStatus.notVerified);

  final AuthStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
