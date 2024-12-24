import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  factory SignInState.initial() = SignInInitial;
  factory SignInState.success() = SignInSuccess;
  factory SignInState.failure({String? message}) = SignInFailure;
  factory SignInState.process() = SignInProcess;
  factory SignInState.emailNotVerified() = SignInSuccessWithoutVerification;
}
